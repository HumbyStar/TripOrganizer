//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import UIKit

class RestaurantViewModel {
    
    private var restaurants: [Restaurant] = []
    
    public func loadRestaurants() {
        restaurants = [
            Restaurant(restaurantName: "Polignano a Mare", restaurantAdress: "70044 Bari, Itália", restaurantOpeningHours: "Aberto", restarauntPhoneNumber: " (+39) 080-4252300", restaurantRating: 4.6,restaurantImages: ["restaurant1.1", "restaurant1.2","restaurant1.3","restaurant1.4","restaurant1.5"]),
        ]
    }
    
    public func cellForRow() -> [Restaurant] {
        return restaurants
    }
    
    public func numberOfRows() -> Int {
        return 5
    }
    
    public func getRestaurantImages(indexPath: IndexPath) -> [String] {
        let restaurant = restaurants[0]
        return restaurant.restaurantImages
    }
    
    public func getCornerRadius(value: CGFloat) -> CGFloat {
        return value
    }
    
    public func getCollectionViewSize(height: CGFloat, extraNumber: CGFloat) -> Double {
        return height - extraNumber
    }
    
    public func getCollectionViewWidth(width: CGFloat) -> Double {
        return width
    }
    
    public func getCollectionViewLayout(collection: UICollectionView) {
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
}
