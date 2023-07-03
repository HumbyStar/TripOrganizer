//
//  Restaurant.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 19/04/23.
//

import Foundation

// MARK: - Restaurant
struct RestaurantModel: Codable {
    let name, address, openingHours, phoneNumber, rating: String
    let images: [String]
}
