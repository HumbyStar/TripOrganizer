//
//  ButtonTitle.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 13/05/23.
//

import Foundation

enum ButtonTitle: String {
    case forgetPassword = "title_button_forgetPassword"
    case createAccount = "title_button_create_account"
    case loginSuccess = "title_button_login_success"
    case loginGoogle = "title_button_login_google"
    case loginApple = "title_button_login_apple"
    case register = "title_button_register"
    case alreadyHaveAccount = "title_button_already_have_account"
    case tapToRegister = "title_button_tap_to_register"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
