//
//  RegisterViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 17/04/23.
//

import Foundation
import UIKit

class RegisterViewModel {
    
    private var passwordData = ""
    
    public func getValidationtapToShowPasswordAndConfirmPassword(textField: UITextField, button: UIButton){
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        if textField.isSecureTextEntry {
            button.setImage(UIImage(systemName: Localized.blockedEye), for: .normal)
        } else {
            button.setImage(UIImage(systemName: Localized.eye), for: .normal)
        }
    }
    
    func validateName(_ name: String) -> Bool {
        return name.isEmpty
    }
    
    func validateEmail(_ email: String) -> Bool {
        if email.isEmpty || ((!email.contains(Localized.atSymbol.localized)) || (!email.contains(Localized.dotCom.localized))) {
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
    
    public func getConfigTextFieldShouldReturn(textField: UITextField, nameTextField: UITextField, emailTextField: UITextField, passwordTextField: UITextField, confirmPasswordTextField: UITextField) -> Bool{
        textField.resignFirstResponder()
        
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
