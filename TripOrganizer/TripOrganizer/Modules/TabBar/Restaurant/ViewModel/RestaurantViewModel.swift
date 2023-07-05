//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import UIKit
import MapKit
import GooglePlaces

class RestaurantViewModel {
    private var restaurantList: [ObjectPlaces] = []
    private var placeService: PlaceService = PlaceService()

    public var isLoading = false
    public var skeletonCount = 0
    public var isUsingMockData = false
    public var localPhotos = [UIImage]()
    public var alertHandler: (() -> Void)?
    public var completion: ((PlaceData) -> Void)?
    public var updateCollectionView: (() -> Void)?
    public var placeClient = GMSPlacesClient.shared()
    public var regionUpdaterHandler: ((MKCoordinateRegion) -> Void)?
    public var annotationUpdateHandler: (([MKPointAnnotation]) -> Void)?

    init() {
        placeService.getPlaceDataJson { data, error in
            if let error = error {
                print("Erro ao recuperar os dados mockados:\(error.localizedDescription)")
            } else {
                self.restaurantList = data?.restaurants ?? []
                
            }
        }
    }
    
    public func switchToMock() {
        self.isUsingMockData = true
        self.completion?(.restaurantModel(self.restaurantList))
    }
    
//    public func getRestaurantImages() -> [String] {
//        return restaurantList[0].images
//    }
    
    public func numberOfItens() -> Int {
        return restaurantList[0].images.count
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
            return CGSize(width: 140, height: height - 20)
        }
    
    public func getCollectionViewLayout(collection: UICollectionView) {
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    public func findRestaurant(typed place: String?){
        guard let place = place else {return}
        CLGeocoder().geocodeAddressString(place) { placemark, error in
            if error == nil {
                guard let firstPlaceMark = placemark?.first else {return}
                guard let coordinate = firstPlaceMark.location?.coordinate else {return}
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
                self.regionUpdaterHandler?(region)
            }
        }
    }
    
    public func buildMKPoints(region: MKCoordinateRegion){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = Localized.titleRestaurantView
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard error == nil, let response = response else {return}
            
            var annotations: [MKPointAnnotation] = []
            
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.coordinate = item.placemark.location?.coordinate ?? MKPointAnnotation.defaultLocation
                annotations.append(annotation)
            }
            self.annotationUpdateHandler?(annotations)
        }
    }
    
    public func searchEstabilishment(value: String, filter: GMSAutocompleteFilter){
        placeClient.findAutocompletePredictions(fromQuery: value, filter: filter, sessionToken: nil) { results, error in

            guard error == nil else {
                self.switchToMock()
                return
            }
            
            guard let results = results, let firstResult = results.first else {
                self.switchToMock()
                return
            }
        
            self.findRestaurantDetails(placeID: firstResult.placeID)
        }
    }
    
    public func findRestaurantDetails(placeID: String) {
        let field: GMSPlaceField = .all
        
        placeClient.fetchPlace(fromPlaceID: placeID, placeFields: field, sessionToken: nil) { localDetails, error in
            guard error == nil else {
                self.switchToMock()
                return
            }
            
            guard let localDetails = localDetails else {
                self.switchToMock()
                return
            }

            self.isUsingMockData = false
            self.completion?(.gmsPlace(localDetails))
        }
    }
    
    public func checkLocalHour(dataHour: GMSPlaceOpenStatus) -> String {
        switch dataHour {
        case .open:
            return Localized.estabilishOpenLabelTitle
        case .closed:
            return Localized.estabilishClosedLabelTitle
        case .unknown:
            return Localized.estabilishUnavailable
        @unknown default:
            return Localized.estabilishUnavailable
        }
    }
    
    public func loadLocalPhotos(photos: [GMSPlacePhotoMetadata]?) {
        skeletonCount = photos?.count ?? 0
        self.localPhotos.removeAll()
        let dispatchGroup = DispatchGroup()
    
        if skeletonCount == 0 {
            self.localPhotos = []
        } else {
            guard let photos = photos else {return}
            for photo in photos {
                dispatchGroup.enter()
                placeClient.loadPlacePhoto(photo) { image, error in
                    if let image = image, error == nil {
                        self.localPhotos.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.updateCollectionView?()
        }
    }
}
