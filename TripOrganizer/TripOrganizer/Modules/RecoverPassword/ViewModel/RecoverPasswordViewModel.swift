//
//  RecoverPasswordViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 17/04/23.
//

import UIKit

class RecoverPasswordViewModel {
    let titleSucess = "Sucesso"
    let messageSuccess = "Um Email de instrução foi enviado para sua caixa de entrada"
    let titleError = "Erro"
    let messageError = "O email digitado não é valido"
    
    func validateConfirmEmail(_ email: String) -> Bool {
        return email.isEmpty || (!email.contains("@") || !email.contains(".com"))
    }
}
