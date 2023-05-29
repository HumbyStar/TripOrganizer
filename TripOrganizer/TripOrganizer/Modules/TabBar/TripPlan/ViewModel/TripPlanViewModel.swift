//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

class TripPlanViewModel {
    
    private var placeList: [TripPlanModel] = [TripPlanModel(name: "Coliseum", images: "teste3"),
                                              TripPlanModel(name: "Paris", images: "teste2"),
                                              TripPlanModel(name: "Restaurante", images: "restaurante1"),
                                              TripPlanModel(name: "Restaurante", images: "restaurante2"),
                                              TripPlanModel(name: "Hotel", images: "hotel1"),
                                              TripPlanModel(name: "Hotel", images: "hotel2"),
                                              TripPlanModel(name: "Hotel", images: "imagehotel")
                                              
    ]
    
    public func getPlaceList(index: Int) -> TripPlanModel {
        placeList[index]
    }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 30
        }
    }
    
    public func getNumberList() -> Int {
        return placeList.endIndex
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat, view: UIView) -> CGSize {
            return CGSize(width: view.frame.width - 70, height: 150)
        }
    
}
