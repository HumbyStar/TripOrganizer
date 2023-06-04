//
//  HotelModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import Foundation

// MARK: - Hotel
struct HotelModel: Codable {
    let room: [String]
    let name, ratings, phoneNumber, address: String
    let openingHours: String
}
