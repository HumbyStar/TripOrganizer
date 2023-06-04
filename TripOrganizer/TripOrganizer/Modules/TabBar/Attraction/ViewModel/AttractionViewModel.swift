//
//  AttractionViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class AttractionViewModel {
    
    private var attractionList: [AttractionModel] = []
    private var placeService: PlaceService = PlaceService()
    
    public func fetchAttractions() {
        placeService.getPlaceDataJson { data, error in
            if error == nil {
                self.attractionList = data?.attractions ?? []
            }
        }
    }
    
    public func getAttractionList() -> [AttractionModel] {
        return attractionList
    }
    
    public func numberOfItens() -> Int {
        return 5
    }
    
    public func getAttractionImages(indexPath: IndexPath) -> [String] {
        let attraction = attractionList[0]
        return attraction.images
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
   }
