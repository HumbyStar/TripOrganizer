//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import UIKit

class HotelViewModel {
    
    private var hotelList: [HotelModel] = []
    private var placeService: PlaceService = PlaceService()

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
    
//    public func getHotelImages(indexPath: IndexPath) -> [String] {
//        let hotel = hotelList[0]
//        return hotel.room
//    }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
            return CGSize(width: 140, height: height - 20)
        }
}
