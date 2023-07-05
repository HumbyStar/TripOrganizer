//
//  User.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 05/07/23.
//

import Foundation

struct User: Codable {
    var userID: String
    var name: String
    var placeList: [ObjectPlaces]
}
