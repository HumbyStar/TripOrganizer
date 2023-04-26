//
//  PerfilViewModel.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import Foundation

class ProfileViewModel {
    
    var username: String
    var email: String
    var phone: String
    var password: String
    
    init(username: String, email: String, phone: String, password: String) {
        self.username = username
        self.email = email
        self.phone = phone
        self.password = password
    }
    
    
    func validateTextField() -> Bool {
        if !username.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
            return true
        } else {
            return false
        }
    }
}

