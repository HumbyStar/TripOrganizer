//
//  AttractionViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class AttractionViewModel {

   private let locationImagelist: [AttractionModel] = [AttractionModel(name:"1"),
                                                AttractionModel(name:"2"),
                                                AttractionModel(name:"3"),
                                                AttractionModel(name:"4"),
                                                AttractionModel(name:"5")]
    
    public func getLocationImagelist() -> Int{
        locationImagelist.count
    }
    
    public func getLocationImageListCellForItemAt(index: Int) -> AttractionModel{
        locationImagelist[index]
    }
    
   public func configLayoutCollectionView(collectionView: UICollectionView){
        
       if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    public func sizeForItem(IndexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
        return CGSize(width: 140, height: height - 20)
    }
    
}
