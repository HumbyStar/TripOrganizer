//
//  PlacesData.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 04/06/23.
//

import Foundation

import Foundation

// MARK: - PlacesData
struct PlacesData: Codable {
    let restaurants: [RestaurantModel]
    let hotels: [HotelModel]
    let attractions: [AttractionModel]
}
