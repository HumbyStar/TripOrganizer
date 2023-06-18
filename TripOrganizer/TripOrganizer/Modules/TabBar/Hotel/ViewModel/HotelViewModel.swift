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
    
    public var regionUpdaterHandler: ((MKCoordinateRegion) -> Void)?
    public var annotationUpdateHandler: (([MKPointAnnotation]) -> Void)?
   

    public func fetchHotels() {
        placeService.getPlaceDataJson { data, error in
            if error == nil {
                self.hotelList = data?.hotels ?? []
            }
        }
    }
    
    public func getHotelList() -> [HotelModel]{
        return hotelList
    }
    
    public func numberOfItens() -> Int {
        return 3
    }
    
    public func getHotelImages(indexPath: IndexPath) -> [String] {
        let hotel = hotelList[0]
        return hotel.room
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
    
    public func findDetails(value: String, filter: GMSAutocompleteFilter){
        
    }
    
}
