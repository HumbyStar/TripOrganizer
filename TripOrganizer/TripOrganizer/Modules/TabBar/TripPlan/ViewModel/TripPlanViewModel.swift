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
    
    private static var hotelList: [HotelModel] = []
    
    private static var objectList: [ProtocolObject] = []
    
    public func addObjectRestaurant(object: RestaurantModel) {
        TripPlanViewModel.objectList.append(object)
        }
    
    public func getSizeRestaurant()-> Int{
        return TripPlanViewModel.objectList.count
    }
    
    public func getRestaurantList(index: Int) -> ProtocolObject {
        return TripPlanViewModel.objectList[index]
    }
    
    public func addObjectHotel(object: HotelModel) {
        TripPlanViewModel.objectList.append(object)
        }
    
//    public func getSizeHotel()-> Int{
//        return TripPlanViewModel.hotelList.count
//    }
//   
    
//    public func getHotelList(index: Int) -> HotelModel {
//        return TripPlanViewModel.hotelList[index]
//    }
//
    public func addObjectAttraction(object: AttractionModel) {
        TripPlanViewModel.objectList.append(object)
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
