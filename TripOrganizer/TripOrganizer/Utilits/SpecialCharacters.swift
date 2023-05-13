//
//  containsTextField.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 13/05/23.
//

import Foundation

enum SpecialCharacters: String {
    case at = "at_symbol"
    case dot = "dot_com"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
