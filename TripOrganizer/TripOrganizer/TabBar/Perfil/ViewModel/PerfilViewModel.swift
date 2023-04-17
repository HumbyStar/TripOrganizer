//
//  PerfilViewModel.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import Foundation

class PerfilViewModel {
    
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    
    func validaTextField() -> Bool {
        if !name.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
            return true
        } else {
            return false
        }
    }
}
