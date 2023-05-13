//
//  RegisterViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 17/04/23.
//

import Foundation

class RegisterViewModel {
    
    let title = messageAlert.title.rawValue
    let message = messageAlert.message.rawValue
    
    private var passwordData = ""
    
    func validateName(_ name: String) -> Bool {
        return name.isEmpty
    }
    
    func validateEmail(_ email: String) -> Bool {
        if email.isEmpty || ((!email.contains("@")) || (!email.contains(".com"))) {
            return true
        } else {
            return false
        }
    }
    
    func validatePassword(_ password: String) -> Bool {
        passwordData = password
        return password.isEmpty || password.count < 6
    }
    
    func validateConfirmPassword(_ confirmPassword: String) -> Bool {
        return (confirmPassword != passwordData) || (confirmPassword.isEmpty)
    }
    
    func validateForms(name: String, email: String, password: String, confirmPassword: String) -> Bool {
        return (!validateName(name) && !validateEmail(email) && !validatePassword(password) && !validateConfirmPassword(confirmPassword))
    }
}
