//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import UIKit

class RestaurantViewModel {
   
    private var restaurantList: [RestaurantModel] = []
    private var placeService: PlaceService = PlaceService()

    
    public func fetchRestaurants() {
        placeService.getPlaceDataJson { data, error in
            if error == nil {
                self.restaurantList = data?.restaurants ?? []
            }
        }
    }
    
    public func getRestaurantList() -> [RestaurantModel] {
        return restaurantList
    }
    
    public func numberOfItens() -> Int {
        return 5
    }
    
    public func getRestaurantImages(indexPath: IndexPath) -> [String] {
        let restaurant = restaurantList[0]
        return restaurant.images
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
}
