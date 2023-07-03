//
//  Restaurant.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import Foundation

// MARK: - Restaurant
class RestaurantModel: Codable, ProtocolObject {
    var name: String
    
    var ratings: String
    
    var phoneNumber: String
    
    var address: String
    
    var openingHours: String
    
    init(name: String, ratings: String, phoneNumber: String, address: String, openingHours: String) {
        self.name = name
        self.ratings = ratings
        self.phoneNumber = phoneNumber
        self.address = address
        self.openingHours = openingHours
    }
//    let name, address, openingHours, phoneNumber: String
//    let rating: String
   // let images: [String]
}
