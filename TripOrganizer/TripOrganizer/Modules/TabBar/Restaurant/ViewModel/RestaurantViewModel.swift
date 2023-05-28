//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import UIKit

class RestaurantViewModel {
    
    private var restaurants: [RestaurantModel] = []
    
    public func loadRestaurants() {
        restaurants = [
            RestaurantModel(name: "Polignano a Mare", address: "70044 Bari, Itália", openingHours: "Aberto", phoneNumber: " (+39) 080-4252300", rating: 4.6,images: ["restaurant1.1", "restaurant1.2","restaurant1.3","restaurant1.4","restaurant1.5"]),
        ]
    }
    
    public func cellForRow() -> [RestaurantModel] {
        return restaurants
    }
    
    public func numberOfRows() -> Int {
        return 5
    }
    
    public func getRestaurantImages(indexPath: IndexPath) -> [String] {
        let restaurant = restaurants[0]
        return restaurant.images
    }
    
    public func  getCornerRadiusCell() -> CGFloat {
        return 10
    }
    
    public func getCornerRadiusImageViewMap() -> CGFloat {
        return 12
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
