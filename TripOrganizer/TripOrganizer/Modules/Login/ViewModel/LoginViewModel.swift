//
//  LoginViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 17/04/23.
//

import UIKit

class LoginViewModel {
    
    var isEyeOpen = false
    
    func validateEmail(_ email: String) -> Bool {
        if email.isEmpty || ((!email.contains(Localized.atSymbol.localized)) || (!email.contains(Localized.dotCom.localized))) {
            return false
        } else {
            return true
        }
    }
    
    func validatePassword(_ password: String) -> Bool {
        return !(password.count < 6)
    }
}
