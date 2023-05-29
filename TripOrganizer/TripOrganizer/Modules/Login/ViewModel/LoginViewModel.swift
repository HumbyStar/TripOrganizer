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
    
    public func getTextFieldShouldReturn(textField: UITextField, emailTextField: UITextField, passwordTextField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
