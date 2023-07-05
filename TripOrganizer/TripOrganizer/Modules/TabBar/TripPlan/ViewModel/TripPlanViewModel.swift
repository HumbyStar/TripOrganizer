//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

class TripPlanViewModel {
    
    private static var objectList: [ObjectPlaces] = []
    
    public func addObjectRestaurant(object: ObjectPlaces) {
        TripPlanViewModel.objectList.append(object)
        }
    
    public func getNumberOfItens()-> Int{
        return TripPlanViewModel.objectList.count
    }
    
    public func getObjectList(index: Int) -> ObjectPlaces {
        return TripPlanViewModel.objectList[index]
    }
    
    public func addObjectHotel(object: ObjectPlaces) {
        TripPlanViewModel.objectList.append(object)
        }
    
    public func addObjectAttraction(object: ObjectPlaces) {
        TripPlanViewModel.objectList.append(object)
        }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 30
        }
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat, view: UIView) -> CGSize {
            return CGSize(width: view.frame.width - 70, height: 190)
        }
    
}

