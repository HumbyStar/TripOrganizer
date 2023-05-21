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
        if email.isEmpty || ((!email.contains(String.atSymbol.localized)) || (!email.contains(String.dotCom.localized))) {
            return false
        } else {
            return true
        }
    }
    
    func validatePassword(_ password: String) -> Bool {
        return !(password.count < 6)
    }
}
