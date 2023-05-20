//
//  Localized.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/05/23.
//

import Foundation

extension String {
    
    //MARK: Screens identifier
    static let RecoverViewController = "RecoverViewController"
    static let RegisterViewController = "RegisterViewController"
    static let TabBarController = "TabBarController"
    static let Main = "Main"
    static let profileViewController = "ProfileViewController"
    static let addTripViewController = "AddTripViewController"
    static let tripPlanViewController = "TripPlanViewController"
    static let ticketsViewController = "TicketsViewController"
    
    //MARK: Message for alerts
    static let title = "title_success".localized
    static let titleConfirm = "confirm_title".localized
    static let tripEmpty = "trip_name_empty".localized
    static let message = "registration_success".localized
    static let titleSuccess = "success_title".localized
    static let messageSuccess = "instruction_email_sent".localized
    static let titleError = "error_title".localized
    static let messageError = "invalid_email".localized
    static let saveDataProfile = "data_changed_successfully".localized
    static let addSuccessFlight = "flight_added_successfully".localized
    static let emailOrPaswordError = "invalid_email_password".localized
    static let registerDataInvalid = "error_register_tap".localized
    
    //MARK: Images
    static let blockedEye = "eye.slash.fill".localized
    static let eyes = "eye".localized
    static let home = "house.fill".localized
    static let airplane = "airplane".localized
    static let hotel = "bed.double.fill".localized
    static let restaurant = "fork.knife".localized
    static let attraction = "heart.fill".localized
    static let square = "square.fill".localized
    static let squareCheck = "checkmark.square.fill".localized
    static let goBack = "arrowshape.turn.up.left.fill".localized
    
    //MARK: Login screen element titles
    static let forgetPassword = "title_button_forgetPassword".localized
    static let createAccount = "title_button_create_account".localized
    static let loginSuccess = "title_button_login_success".localized
    static let loginGoogle = "title_button_login_google".localized
    static let loginApple = "title_button_login_apple".localized
    static let register = "title_button_register".localized
    static let alreadyHaveAccount = "title_button_already_have_account".localized
    static let tapToRegister = "title_button_tap_to_register".localized
    //MARK: Title label of confirmEmailDescription
    static let confirmEmailDescription = "text_confirm_email_label".localized
    
    //MARK: Symbols
    static let at = "at_symbol".localized
    static let dot = "dot_com".localized
    
    //MARK: PlaceHolders
    static let name = "name_placeholder".localized
    static let email = "email_placeholder".localized
    static let password = "password_placeholder".localized
    static let confirPassword = "confirm_password_placeholder".localized
    
    
    
    
    
    
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
