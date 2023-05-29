//
//  LoginViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 17/04/23.
//

import UIKit

class LoginViewModel {
    
   public var isEyeOpen = false
    
  public func validateEmail(_ email: String) -> Bool {
        if email.isEmpty || ((!email.contains(Localized.atSymbol.localized)) || (!email.contains(Localized.dotCom.localized))) {
            return false
        } else {
            return true
        }
    }
    
  public func validatePassword(_ password: String) -> Bool {
        return !(password.count < 6)
    }
    
    public func getTextFieldDidBeginEditing(textField: UITextField, emailTextField: UITextField, passwordView: UIView){
        if textField == emailTextField {
            emailTextField.layer.borderWidth = 3
            emailTextField.layer.borderColor = UIColor.logoGreen.cgColor
        } else {
            passwordView.layer.borderWidth = 3
            passwordView.layer.borderColor = UIColor.logoGreen.cgColor
        }
    }
    
}
