//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

protocol TripPlanViewModelProtocol: AnyObject {
    func sucess()
    func error()
}

class TripPlanViewModel {
    
    private var fireStoreManager = FirestoreManager.shared
    private var objectList: [ObjectPlaces] = []
    private var delegate: TripPlanViewModelProtocol?
    
    public func delegate(delegate: TripPlanViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func fetchPlaces() {
        fireStoreManager.getObjectData(collection: "user", forObjectType: User.self) { result in
            switch result {
            case .success(let sucess):
                self.objectList = sucess.placeList
                self.delegate?.sucess()
            case .failure(let error):
                print(error)
                self.delegate?.error()
            }
        }
    }
    
    public func addObjectRestaurant(object: ObjectPlaces) {
        objectList.append(object)
    }
    
    public func getNumberOfItens()-> Int{
        objectList.count
    }
    
    public func getObjectList(index: Int) -> ObjectPlaces {
        objectList[index]
    }
    
    public func addObjectHotel(object: ObjectPlaces) {
        objectList.append(object)
    }
    
    public func addObjectAttraction(object: ObjectPlaces) {
        objectList.append(object)
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

