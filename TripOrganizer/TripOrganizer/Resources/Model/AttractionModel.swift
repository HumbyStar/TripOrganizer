//
//  AttractionModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import Foundation

// MARK: - Attraction
class AttractionModel: Codable, ProtocolObject {
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
    //    let images: [String]
//    let ratings, name, address, openingHours: String
//    let phoneNumber, entranceFee: String
}
