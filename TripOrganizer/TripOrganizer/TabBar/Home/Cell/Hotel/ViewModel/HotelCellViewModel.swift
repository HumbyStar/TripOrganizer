//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

class HotelCellViewModel {
    
    private var hotelList: [Image] = [Image(nameImages: "imagehotel"), Image(nameImages: "hotel1"), Image(nameImages: "hotel2")]
    
    public func hotelNumberOfItemsInSection() -> Int {
        hotelList.count
    }
    
    public func hotelCellForItemAt(index: Int) -> Image {
        hotelList[index]
    }
    
    public func configureLayout(collectionView: UICollectionView) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
    }
}
