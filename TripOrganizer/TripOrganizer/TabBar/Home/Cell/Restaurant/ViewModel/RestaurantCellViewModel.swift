//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

class RestaurantCellViewModel {
    
    private var restaurantList: [Image] = [Image(nameImages: "restaurante1"), Image(nameImages: "restaurante2")]
    
    public func getRestautantListSize() -> Int {
        restaurantList.count
    }
    
    public func getImage(index: Int) -> Image {
        restaurantList[index]
    }
    
    public func configureLayout(collectionView: UICollectionView) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
    }
}
