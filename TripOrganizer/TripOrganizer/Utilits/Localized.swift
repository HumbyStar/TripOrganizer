//
//  Localized.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/05/23.
//

import Foundation

extension String {
    
    //MARK: Routes identifier
    static let recoverViewController = "RecoverViewController"
    static let registerViewController = "RegisterViewController"
    static let tabBarController = "TabBarController"
    static let main = "Main"
    static let profileViewController = "ProfileViewController"
    static let addTripViewController = "AddTripViewController"
    static let tripPlanViewController = "TripPlanViewController"
    static let ticketsViewController = "TicketsViewController"
    
    //MARK: System Images
    static let blockedEye = "eye.slash.fill"
    static let eye = "eye"
    static let home = "house.fill"
    static let airplane = "airplane"
    static let hotel = "bed.double.fill"
    static let restaurant = "fork.knife"
    static let attraction = "heart.fill"
    static let square = "square.fill"
    static let squareCheck = "checkmark.square.fill"
    static let goBack = "arrowshape.turn.up.left.fill"
    
    //MARK: Message for alerts
    static let confirmTitle = "misc.confirm_title".localized
    static let tripNameEmpty = "error.trip_name_empty".localized
    static let registrationSuccessMessage = "registration.success_message".localized
    static let successTitle = "misc.success_title".localized
    static let instructionEmailSent = "misc.instruction_email_sent".localized
    static let errorTitle = "misc.error_title".localized
    static let invalidEmail = "error.invalid_email".localized
    static let invalidEmailPassword = "error.invalid_email_password".localized
    static let dataChangedSuccessfully = "error.data_changed_successfully".localized
    static let flightAddedSuccessfully = "error.flight_added_successfully".localized
    static let registerTapError = "error.register_tap".localized
    
    //MARK: Button titles
    static let forgetPasswordButtonTitle = "button.title_forget_password".localized
    static let createAccountButtonTitle = "button.title_create_account".localized
    static let loginSuccessButtonTitle = "button.title_login_success".localized
    static let loginGoogleButtonTitle = "button.title_login_google".localized
    static let loginAppleButtonTitle = "button.title_login_apple".localized
    static let registerButtonTitle = "button.title_register".localized
    static let alreadyHaveAccountButtonTitle = "button.title_already_have_account".localized
    static let tapToRegisterButtonTitle = "button.title_tap_to_register".localized
    static let changeImageButtonTitle = "button.title_change_image".localized
    static let saveButtonTitle = "button.title_save".localized
    static let exitButtonTitle = "button.title_exit".localized
    
    //MARK: Titles
    static let nameProfileTitle = "profile.title_name".localized
    static let emailProfileTitle = "profile.title_email".localized
    static let phoneProfileTitle = "profile.title_phone".localized
    static let changePasswordProfileTitle = "profile.title_change_password".localized
    static let phoneProfileUserTitle = "profile.phone_placeholder".localized
    
    //MARK: Title label of confirmEmailDescription
    static let confirmEmailDescription = "misc.confirm_email_label".localized
    
    //MARK: Symbols
    static let atSymbol = "at_symbol".localized
    static let dotCom = "dot_com".localized
    
    //MARK: Placeholders
    static let namePlaceholder = "registration.name_placeholder".localized
    static let emailPlaceholder = "registration.email_placeholder".localized
    static let passwordPlaceholder = "registration.password_placeholder".localized
    static let confirmPasswordPlaceholder = "registration.confirm_password_placeholder".localized
    static let namePlaceholderProfile = "profile.name_placeholder".localized
    static let emailPlaceholderProfile = "profile.email_placeholder".localized
    
    
    
    
    
    
    
    
    
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
