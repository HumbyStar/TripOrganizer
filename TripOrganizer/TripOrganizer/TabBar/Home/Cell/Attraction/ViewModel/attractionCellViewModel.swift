//
//  attractionCellViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

class attractionCellViewModel {

    private var attractionList: [Image] = [Image(nameImages: "parque"),Image(nameImages: "parque1"),Image(nameImages: "1"),Image(nameImages: "2"),Image(nameImages: "3"),Image(nameImages: "4"),Image(nameImages: "5")]
    
    //["parque", "parque1", "1", "2", "3", "4", "5"]
    public func getAttractionListSize() -> Int {
        attractionList.count
    }
    
    public func getImage(index: Int) -> Image {
        return attractionList[index]
    }
    
    
    public func configureLayout(collectionView: UICollectionView) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
}
