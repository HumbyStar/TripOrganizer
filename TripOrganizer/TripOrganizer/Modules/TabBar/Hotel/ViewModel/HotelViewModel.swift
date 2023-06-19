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
    public var alertHandler: (() -> Void)?
    public var completion: ((GMSPlace) -> Void)?
    
    var placeClient = GMSPlacesClient.shared()
   

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
    
    public func searchEstabilishment(value: String, filter: GMSAutocompleteFilter){
        placeClient.findAutocompletePredictions(fromQuery: value, filter: filter, sessionToken: nil) { results, error in
            guard error == nil else {
                print("Erro ao tentar recuperar informações dos locais ao redor \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let results = results else{
                print("Nenhuma sugestão de lugar encontrada")
                return
            }
            
            guard let firstResult = results.first else {
                print("Não existe lugar disponível")
                self.alertHandler?()
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
                return
            }
            
            guard let localDetails = localDetails else {
                print("Erro, não possível recuperar os detalhes dos lugares na lista")
                return
            }
            
            //TODO comunicar com a viewController para realizar as animações
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
    
    public func loadLocalPhotos(photos: [GMSPlacePhotoMetadata]) -> [UIImage] {
        var localPhotos = [UIImage]()
        for photo in photos {
            placeClient.loadPlacePhoto(photo) { image, error in
                guard error == nil else {
                    print("Erro ao recuperar imagem")
                    return
                }
                
                guard let image = image else {return}
                localPhotos.append(image)
            }
        }
        return localPhotos
    }
    
}
