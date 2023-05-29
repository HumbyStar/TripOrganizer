//
//  LoginViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 17/04/23.
//

import UIKit

class LoginViewModel {
   
    
    
    
   public var isEyeOpen = false
    
    public func getValidationTappedEyeButton(eyeButton: UIButton, passwordTextField: UITextField ) {
        if isEyeOpen {
            eyeButton.setImage(UIImage(systemName: Localized.blockedEye), for: .normal)
            passwordTextField.isSecureTextEntry = true
            isEyeOpen = false
        } else {
            eyeButton.setImage(UIImage(systemName: Localized.eye), for: .normal)
            passwordTextField.isSecureTextEntry = false
          isEyeOpen = true
        }
    }
    
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
    
    public func getTextFieldShouldReturn(textField: UITextField, emailTextField: UITextField, passwordTextField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
