//
//  PlaceHolder.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 13/05/23.
//

import Foundation

enum TextfieldPlaceholder: String {
    case name = "name_placeholder"
    case email = "email_placeholder"
    case password = "password_placeholder"
    case confirPassword = "confirm_password_placeholder"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

