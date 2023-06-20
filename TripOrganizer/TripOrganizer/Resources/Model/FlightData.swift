//
//  FlightData.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

struct FlightData: Decodable {
    let data: [Flight]
}

struct Flight: Decodable {
    let id: String
    let price: Price
    let legs: [Leg]
    let is_eco_contender: Bool
    let eco_contender_delta: Float
    let score: Float
    let totalDuration: Int
}

struct Price: Decodable {
    let amount: Double
    let update_status: String
    let last_updated: String
    let quote_age: Int
    let score: Float
    let transfer_type: String
}

struct Leg: Decodable {
    let id: String
    let origin: Airport
    let destination: Airport
    let departure: String
    let arrival: String
    let duration: Int
    let carriers: [Carrier]
    let stop_count: Int
    let stops: [Stop]
}

struct Airport: Decodable {
    let id: Int
    let entity_id: Int
    let alt_id: String
    let parent_id: Int
    let parent_entity_id: Int
    let name: String
    let type: String
    let display_code: String
}

struct Carrier: Decodable {
    let id: Int
    let name: String
    let alt_id: String
    let display_code: String
    let display_code_type: String
}

struct Stop: Decodable {
   
}

