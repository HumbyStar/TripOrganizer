//
//  RecoverPasswordViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 17/04/23.
//

import UIKit

class RecoverPasswordViewModel {
    func validateConfirmEmail(_ email: String) -> Bool {
        return email.isEmpty || (!email.contains(SpecialCharacters.at.localized) || !email.contains(SpecialCharacters.dot.localized))
    }
}
