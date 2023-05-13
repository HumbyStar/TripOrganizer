//
//  mensageAlert.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 13/05/23.
//

import Foundation

enum MessageAlert: String {
    case title = "title_success"
    case titleConfirm = "confirm_title"
    case tripEmpty = "trip_name_empty"
    case message = "registration_success"
    case titleSuccess = "success_title"
    case messageSuccess = "instruction_email_sent"
    case titleError = "error_title"
    case messageError = "invalid_email"
    case saveDataProfile = "data_changed_successfully"
    case addSuccessFlight = "flight_added_successfully"
    case emailOrPaswordError = "invalid_email_password"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
