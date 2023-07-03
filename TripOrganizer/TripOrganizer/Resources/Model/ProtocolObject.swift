//
//  ProtocolObject.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 28/06/23.
//

import Foundation

protocol ProtocolObject: AnyObject {
    var name: String { get }
    var ratings: String { get }
    var phoneNumber: String { get }
    var address: String { get }
    var openingHours: String { get }
}
