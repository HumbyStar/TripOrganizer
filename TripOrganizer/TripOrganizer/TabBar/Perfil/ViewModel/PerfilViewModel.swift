//
//  PerfilViewModel.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import Foundation

class PerfilViewModel {
    
//    var name: String = ""
//    var email: String = ""
//    var phone: String = ""
//    var password: String = ""
    
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
    
//    func validaTextField() -> Bool {
//        if !name.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
//            return true
//        } else {
//            return false
//        }
//    }
    
    
    func validateTextField() -> Bool {
        if !username.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
    //    func validateTextField2() -> Bool{
    //        if !perfilViewController.nameTextField.hasText &&  !perfilViewController.emailTextField.hasText && !perfilViewController.phoneTextField.hasText && !perfilViewController.changePasswordTextField.hasText {
    //            return true
    //        } else {
    //            return false
    //        }
    //    }
    
}
