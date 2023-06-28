//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

class TripPlanViewModel {
    
   var restaurantViewModel: RestaurantViewModel = RestaurantViewModel()
    
  private static var restaurantList: [RestaurantModel] = []
    
    public func addObjectRestaurant(object: RestaurantModel) {
        TripPlanViewModel.restaurantList.append(object)
        }
    
    public func getSizeRestaurant()-> Int{
        return TripPlanViewModel.restaurantList.count
    }
   
    public func getRestaurantList2()-> [RestaurantModel]{
        return TripPlanViewModel.restaurantList
    }
    
    public func getRestaurantList(index: Int) -> RestaurantModel {
        return TripPlanViewModel.restaurantList[index]
    }
//    public func getRestaurantList() -> [RestaurantModel]{
//        return restaurantList
//    }
    
        //  private var restaurants: [RestaurantModel] = []
    
//    private var placeList: [TripPlanModel] = []
//
//    public func getPlaceList(index: Int) -> TripPlanModel {
//        placeList[index]
//    }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 30
        }
    }
    
//    func getRestaurantList(index: Int)-> RestaurantModel {
//    //    restaurants = restaurantViewModel.getRestaurantList()
//        return restaurants[index]
//    }
//
//    public func getNumberList() -> Int {
//        return restaurants.endIndex
//    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat, view: UIView) -> CGSize {
            return CGSize(width: view.frame.width - 70, height: 150)
        }
    
}

//extension TripPlanViewModel: RestaurantViewControllerProtocol {
//    func getObjectRestaurant(object: [RestaurantModel]) {
//        self.restaurants = object
//    }
//}
