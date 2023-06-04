//
//  AttractionModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import Foundation

// MARK: - Attraction
struct AttractionModel: Codable {
    let images: [String]
    let ratings, name, address, openingHours: String
    let phoneNumber, entranceFee: String
}
