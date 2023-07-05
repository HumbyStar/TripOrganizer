//
//  PlacesData.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 04/06/23.
//

import Foundation

// MARK: - PlacesData
struct PlacesData: Codable {
    let restaurants: [ObjectPlaces]
    let hotels: [ObjectPlaces]
    let attractions: [ObjectPlaces]
}
