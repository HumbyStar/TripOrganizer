//
//  HotelModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import Foundation

// MARK: - Hotel
class HotelModel: Codable, ProtocolObject {
    
    var images: Data
    
    var name: String
    
    var ratings: String
    
    var phoneNumber: String
    
    var address: String
    
    var openingHours: String
    
    init(name: String, ratings: String, phoneNumber: String, address: String, openingHours: String, images: Data) {
        self.name = name
        self.ratings = ratings
        self.phoneNumber = phoneNumber
        self.address = address
        self.openingHours = openingHours
        self.images = images
    }
   // let room: [String]
//    let name, ratings, phoneNumber, address: String
//    let openingHours: String
}
