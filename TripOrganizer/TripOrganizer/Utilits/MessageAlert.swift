//
//  mensageAlert.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 13/05/23.
//

import Foundation

enum messageAlert: String {
    case titleEmpty = "" 
    case title = "TripOrganizer"
    case messageEmpty = "Sua viagem deve conter um nome!"
    case message = "Cadastro Efetuado com sucesso!"
    case titleSucess = "Sucesso"
    case messageSuccess = "Um Email de instrução foi enviado para sua caixa de entrada"
    case titleError = "Erro"
    case messageError = "O email digitado não é valido"
    case saveDataProfile = "Dados alterados com sucesso!"
    case addSucessFlight = "Voo adicionado com sucesso a sua lista de viagem!"
}
