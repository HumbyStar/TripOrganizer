//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import UIKit
import MapKit
import GooglePlaces

class HotelViewModel {
    
    private var hotelList: [HotelModel] = []
    private var placeService: PlaceService = PlaceService()
    
    public var isLoading = false
    public var skeletonCount = 0
    public var isUsingMockData = false
    public var localPhotos = [UIImage]()
    public var alertHandler: (() -> Void)?
    public var completion: ((GMSPlace) -> Void)?
    public var updateCollectionView: (() -> Void)?
    public var placeClient = GMSPlacesClient.shared()
    public var regionUpdaterHandler: ((MKCoordinateRegion) -> Void)?
    public var annotationUpdateHandler: (([MKPointAnnotation]) -> Void)?
    
    public func fetchHotels() {
        placeService.getPlaceDataJson { data, error in
            if let error = error {
                print("Erro ao recuperar os dados mockados:\(error.localizedDescription)")
            } else {
                self.hotelList = data?.hotels ?? []
                self.isUsingMockData = true
            }
        }
    }
    
    public func getHotelList() -> [HotelModel]{
        return hotelList
    }
    
    public func numberOfItens() -> Int {
        return 3
    }
    
    public func resetHotelList() {
        hotelList = []
    }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
            return CGSize(width: 140, height: height - 20)
        }
    
    public func findHotel(typed place: String?){
        guard let place = place else {return}
        CLGeocoder().geocodeAddressString(place) { placemark, error in
            if error == nil {
                guard let firstPlaceMark = placemark?.first else {return}
                guard let coordinate = firstPlaceMark.location?.coordinate else {return}
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
                self.regionUpdaterHandler?(region)
            } else {
                print("Não foi possível achar o erro descrito")
            }
        }
    }
    
    public func buildMKPoints(region: MKCoordinateRegion){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Hotel"
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
                print("Erro ao tentar recuperar informações dos locais ao redor \(error?.localizedDescription ?? "")")
                self.fetchHotels()
                return
            }
            
            guard let results = results, let firstResult = results.first else{
                print("Nenhuma sugestão de lugar encontrada")
                self.fetchHotels()
                return
            }
        
            self.findHotelDetails(placeID: firstResult.placeID)
        }
    }
    
    public func findHotelDetails(placeID: String){
        let field: GMSPlaceField = .all
        
        placeClient.fetchPlace(fromPlaceID: placeID, placeFields: field, sessionToken: nil) { localDetails, error in
            guard error == nil else {
                print("Erro ao recuperar o local")
                self.fetchHotels()
                return
            }
            
            guard let localDetails = localDetails else {
                print("Erro, não possível recuperar os detalhes dos lugares na lista")
                self.fetchHotels()
                return
            }

            self.isUsingMockData = false
            self.completion?(localDetails)
        }
    }
    
    public func checkLocalHour(dataHour: GMSPlaceOpenStatus) -> String {
        switch dataHour {
        case .open:
            return "Funcionamento - Estabelecimento Aberto"
        case .closed:
            return "Funcionamento - Estabelecimento Fechado"
        case .unknown:
            return "Funcionamento - Dado indisponível"
        @unknown default:
            return "Funcionamento - Dado indisponível"
        }
    }
    
    public func loadLocalPhotos(photos: [GMSPlacePhotoMetadata]) {
        skeletonCount = photos.count
        self.localPhotos.removeAll()
        let dispatchGroup = DispatchGroup()
        
        for photo in photos {
            dispatchGroup.enter()
            placeClient.loadPlacePhoto(photo) { image, error in
                if let image = image, error == nil {
                    self.localPhotos.append(image)
                } else {
                    print("Ocorreu um erro para recuperar a imagem")
                }
                
                
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.updateCollectionView?()
        }
    }
    
}
