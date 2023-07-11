//
//  Model.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 22/04/23.
//

import Foundation

struct AddTripModel: Codable {
    var tripName: String
    var departureDate: String
    var returnDate: String
    var placeList: [Places]
}

