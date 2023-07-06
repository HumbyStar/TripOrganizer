//
//  TicketsModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

// MARK: - TicketsModel
struct Tickets: Codable {
    let status: Bool?
    let data: [Ticket]?
}

// MARK: - Ticket
struct Ticket: Codable {
    let price: Price?
    let legs: [Leg]?

    enum CodingKeys: String, CodingKey {
        case price, legs
    }
}

// MARK: - Leg
struct Leg: Codable {
    let origin, destination: Destination?
    let departure, arrival: String?
    let duration: Int?
    let carriers: [Carrier]?

    enum CodingKeys: String, CodingKey {
        case origin, destination, departure, arrival, duration, carriers
    }
}

// MARK: - Carrier
struct Carrier: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - Destination
struct Destination: Codable {
    let altID: String?
    let name: String?
    let displayCode: String?

    enum CodingKeys: String, CodingKey {
        case altID = "alt_id"
        case name
        case displayCode = "display_code"
    }
}

// MARK: - Price
struct Price: Codable {
    let amount: Double?

    enum CodingKeys: String, CodingKey {
        case amount
    }
}

