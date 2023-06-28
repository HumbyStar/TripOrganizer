//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import UIKit

protocol RestaurantViewModelProtocol: AnyObject {
    func getObjectRestaurant(object: [RestaurantModel])
}

class RestaurantViewModel {
   
    weak var delegate: RestaurantViewModelProtocol?
    private var restaurantList: [RestaurantModel] = []
    private var placeService: PlaceService = PlaceService()

    
    
    public func setDelegate(delegate: RestaurantViewModelProtocol?){
        self.delegate = delegate
    }
//    public func fetchRestaurants() {
//        placeService.getPlaceDataJson { data, error in
//            if error == nil {
//                self.restaurantList = data?.restaurants ?? []
//            }
//        }
//    }
    
   public func addObjectRestaurant(object: RestaurantModel) {
       restaurantList.append(object)
       self.delegate?.getObjectRestaurant(object: restaurantList)
    }

    public func getRestaurantList(index: Int) -> RestaurantModel {
        return restaurantList[index]
    }
    
    public func getRestaurantList() -> [RestaurantModel] {
        return restaurantList
    }
    
    public func getSizeRestaurant()-> Int{
        return restaurantList.count
    }
    public func numberOfItens() -> Int {
        return 5
    }
    
//    public func getRestaurantImages(indexPath: IndexPath) -> [String] {
//        let restaurant = restaurantList[0]
//        return restaurant.images
//    }
    
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
