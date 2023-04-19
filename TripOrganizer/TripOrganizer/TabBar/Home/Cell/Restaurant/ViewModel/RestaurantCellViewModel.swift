//
//  RestaurantViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import Foundation

class RestaurantCellViewModel {
    
    private var restaurantList: [Image] = [Image(nameImages: "restaurante1"), Image(nameImages: "restaurante2")]
    
    public func getRestautantListSize() -> Int {
        restaurantList.count
    }
    
    public func getImage(index: Int) -> Image {
        restaurantList[index]
    }
}
