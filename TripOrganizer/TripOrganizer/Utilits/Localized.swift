//
//  Localized.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/05/23.
//

import Foundation

extension String {
    
    //MARK: Routes identifier
    static let RecoverViewController = "RecoverViewController"
    static let RegisterViewController = "RegisterViewController"
    static let TabBarController = "TabBarController"
    static let Main = "Main"
    static let profileViewController = "ProfileViewController"
    static let addTripViewController = "AddTripViewController"
    static let tripPlanViewController = "TripPlanViewController"
    static let ticketsViewController = "TicketsViewController"
    
    //MARK: System Images
    static let blockedEye = "eye.slash.fill"
    static let eyes = "eye"
    static let home = "house.fill"
    static let airplane = "airplane"
    static let hotel = "bed.double.fill"
    static let restaurant = "fork.knife"
    static let attraction = "heart.fill"
    static let square = "square.fill"
    static let squareCheck = "checkmark.square.fill"
    static let goBack = "arrowshape.turn.up.left.fill"
    
    
    //MARK: Message for alerts
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
    
    //MARK: Button titles
    static let titleButtonForgetPassword = "title_button_forgetPassword".localized
    static let titleButtonCreateAccount = "title_button_create_account".localized
    static let titleButtonLoginSuccess = "title_button_login_success".localized
    static let titleButtonLoginGoogle = "title_button_login_google".localized
    static let titleButtonLogin_apple = "title_button_login_apple".localized
    static let titleButtonRegister = "title_button_register".localized
    static let titleButtonAlreadyHaveAccount = "title_button_already_have_account".localized
    static let titleButtonTapToRegister = "title_button_tap_to_register".localized
    static let buttonTitleChangeImage = "button_title_change_image"
    static let saveButtonTitle = "save_button_title"
    static let exitButtonTitle = "exit_button_title"
    
    //MARK: titles
    static let titleNameProfile = "title_name_profile".localized
    static let tileEmailProfile = "tile_email_profile".localized
    static let titlePhoneProfile = "title_phone_profile".localized
    static let titleChangePasswordProfile = "title_change_password_profile".localized
    static let titlePhoneProfileUser = "title_phone_profile_user"
    
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
    static let namePlaceholderProfile = "name_placeholder_profile".localized
    static let emailPlaceholderProfile = "email_placeholder_profile".localized
    
    
    
    
    
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
