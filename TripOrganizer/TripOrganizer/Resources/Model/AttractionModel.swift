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
    let rating, name, address, phoneNumber, entranceFee, openingHours: String
}
