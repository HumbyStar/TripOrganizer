//
//  PerfilViewModel.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    public func getCircleBorderImageView(profileImageView: UIImageView){
        profileImageView.layer.cornerRadius = min(profileImageView.frame.width, profileImageView.frame.height) / 2
        profileImageView.clipsToBounds = true
    }
    
    public func getBorderWidthProfileImage() -> CGFloat {
    return 3
    }
    
    public func getBorderWidthDefaultTextField()-> CGFloat {
        return 2
    }
    
    public func getBorderWidthTextField()-> CGFloat{
        return 3
    }
   
    public func getCornerRadiusTextField() -> CGFloat {
    return 10
    }

    
    
    public func getConfigTextFieldDidEndEditing(textField: UITextField, nameTextField: UITextField, emailTextField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

