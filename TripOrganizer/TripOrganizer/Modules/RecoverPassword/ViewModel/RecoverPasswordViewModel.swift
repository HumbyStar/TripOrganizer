//
//  RecoverPasswordViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 17/04/23.
//

import UIKit

class RecoverPasswordViewModel {
    let titleSucess = messageAlert.titleSucess.rawValue
    let messageSuccess = messageAlert.messageSuccess.rawValue
    let titleError = messageAlert.titleError.rawValue
    let messageError = messageAlert.messageError.rawValue
    
    func validateConfirmEmail(_ email: String) -> Bool {
        return email.isEmpty || (!email.contains("@") || !email.contains(".com"))
    }
}
