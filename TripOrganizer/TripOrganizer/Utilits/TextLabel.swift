//
//  TextLabel.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 13/05/23.
//

import Foundation

enum TextLabel: String {
    case confirmEmailDescription = "text_confirm_email_label"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
