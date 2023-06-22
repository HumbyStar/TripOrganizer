//
//  TicketsModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

// MARK: - CurrencyData
struct TicketsModel: Codable {
    let status: Bool?
//    let message: String?
//    let timestamp: Int?
    let data: [Ticket]?
}

// MARK: - Datum
struct Ticket: Codable {
    let price: Price?
    let legs: [Leg]?
//    let isEcoContender: Bool?
//    let ecoContenderDelta, score: Double?
//    let totalDuration: Int?

    enum CodingKeys: String, CodingKey {
        case price, legs
//        case isEcoContender = "is_eco_contender"
//        case ecoContenderDelta = "eco_contender_delta"
//        case score, totalDuration
    }
}

// MARK: - Leg
struct Leg: Codable {
//    let id: String?
    let origin, destination: Destination?
    let departure, arrival: String?
    let duration: Int?
    let carriers: [Carrier]?
//    let stopCount: Int?
//    let stops: [Destination]?

    enum CodingKeys: String, CodingKey {
        case origin, destination, departure, arrival, duration, carriers
//        case stopCount = "stop_count"
//        case stops
    }
}

// MARK: - Carrier
struct Carrier: Codable {
//    let id: Int?
    let name: String?
//    let altID, displayCode: CarrierAltID?
//    let displayCodeType: DisplayCodeType?
//    let brand: Int?

    enum CodingKeys: String, CodingKey {
        case name
//        case altID = "alt_id"
//        case displayCode = "display_code"
//        case displayCodeType = "display_code_type"
//        case brand
    }
}

// MARK: - Destination
struct Destination: Codable {
//    let id, entityID: Int?
    let altID: String?
//    let parentID, parentEntityID: Int?
    let name: String?
//    let type: TypeEnum?
    let displayCode: String?

    enum CodingKeys: String, CodingKey {
//        case id
//        case entityID = "entity_id"
        case altID = "alt_id"
//        case parentID = "parent_id"
//        case parentEntityID = "parent_entity_id"
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


//// MARK: - TicketsModel
//struct TicketsModel: Codable {
//    let data: [Ticket]
//}
//
//// MARK: - Ticket
//struct Ticket: Codable {
//    let id: String
//    let price: Price
//    let legs: [Leg]
//    let isEcoContender: Bool
//    let ecoContenderDelta, score: Double
//    let totalDuration: Int
//}
//
//// MARK: - Leg
//struct Leg: Codable {
//    let id: String
//    let origin, destination: Destination
//    let departure, arrival: String
//    let duration: Int
//    let carriers: [Carrier]
//    let stopCount: Int?
//    let stops: [Destination]
//}
//
//// MARK: - Carrier
//struct Carrier: Codable {
//    let id: Int?
//    let name: String?
//    let brand: Int?
//
//}
//
//// MARK: - Destination
//struct Destination: Codable {
//    let id, entityID: Int?
//    let name: String?
//
//}
//
//// MARK: - Price
//struct Price: Codable {
//    let amount: Double
//}
