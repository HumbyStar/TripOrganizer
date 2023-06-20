//
//  TicketsModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

// MARK: - TicketsModel
struct TicketsModel: Codable {
    let data: [Ticket]
}

// MARK: - Ticket
struct Ticket: Codable {
    let id: String
    let price: Price
    let legs: [Leg]
    let isEcoContender: Bool
    let ecoContenderDelta, score: Double
    let totalDuration: Int
}

// MARK: - Leg
struct Leg: Codable {
    let id: String
    let origin, destination: Destination
    let departure, arrival: String
    let duration: Int
    let carriers: [Carrier]
    let stopCount: Int?
    let stops: [Destination]
}

// MARK: - Carrier
struct Carrier: Codable {
    let id: Int?
    let name: String?
    let brand: Int?

}

// MARK: - Destination
struct Destination: Codable {
    let id, entityID: Int?
    let name: String?

}

// MARK: - Price
struct Price: Codable {
    let amount: Double
}
