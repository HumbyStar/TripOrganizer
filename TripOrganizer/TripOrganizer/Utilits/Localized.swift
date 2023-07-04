//
//  Localized.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/05/23.
//

import Foundation

class Localized {
    
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
    static let attention = "error.attention".localized
    static let confirmTitle = "misc.confirm_title".localized
    static let dataChangedSuccessfully = "misc.data_changed_successfully".localized
    static let errorTitle = "misc.error_title".localized
    static let flightAddedSuccessfully = "misc.flight_added_successfully".localized
    static let instructionEmailSent = "misc.instruction_email_sent".localized
    static let invalidData = "error.invalid_data".localized
    static let invalidEmail = "error.invalid_email".localized
    static let invalidEmailPassword = "error.invalid_email_password".localized
    static let logInSuccessfullyMessage = "misc.log_successfully".localized
    static let loginErroMessage = "error.login_message".localized
    static let registrationErrorMessage = "registration.error_message".localized
    static let registrationSuccessMessage = "registration.success_message".localized
    static let registerTapError = "error.register_tap".localized
    static let successTitle = "misc.success_title".localized
    static let tripNameEmpty = "error.trip_name_empty".localized
    static let EmailToResetPassword = "email.reset_password".localized
    static let sentEmail = "email_send".localized
    static let emailNotRegistered = "not.registered_email".localized
    static let errorSendingEmail = "error.sending_email".localized
    
    //MARK: Button titles
    static let addFlight = "button.add_flight".localized
    static let addButtonTitle = "button.add_title".localized
    static let addTripButtonTitle = "button.title_add_trip".localized
    static let alreadyHaveAccountButtonTitle = "button.title_already_have_account".localized
    static let changeImageButtonTitle = "button.title_change_image".localized
    static let createAccountButtonTitle = "button.title_create_account".localized
    static let exitButtonTitle = "button.title_exit".localized
    static let forgetPasswordButtonTitle = "button.title_forget_password".localized
    static let loginAppleButtonTitle = "button.title_login_apple".localized
    static let loginGoogleButtonTitle = "button.title_login_google".localized
    static let loginSuccessButtonTitle = "button.title_login_success".localized
    static let registerButtonTitle = "button.title_register".localized
    static let saveButtonTitle = "button.title_save".localized
    static let tapToRegisterButtonTitle = "button.title_tap_to_register".localized
    
    //MARK: Title label
    static let accommodationTitle = "Label.title_accommodation".localized
    static let addressTitle = "label.title_address".localized
    static let assessmentsTitle = "label.title_assessments".localized
    static let changePasswordProfileTitle = "label.title_change_password".localized
    static let changeProgressTitle = "label.title_change_Progress".localized
    static let confirmEmailDescription = "misc.confirm_email_label".localized
    static let departureDateFlight = "label.title_departure_date".localized
    static let emailTitle = "label.title_email".localized
    static let entranceFeeLabelAttractionLabel = "title.entrance_free".localized
    static let id = "id".localized
    static let menuRestaurantTitle = "title.restaurant_menu".localized
    static let nameOfFlight = "label.title_new_flight".localized
    static let nameTitle = "label.title_name".localized
    static let phoneProfileTitle = "label.title_phone".localized
    static let phoneProfileUserTitle = "profile.phone_placeholder".localized
    static let phoneTitle = "label.title_phone".localized
    static let popularDestinationsTitle = "label.title_popular_Destinations".localized
    static let returnDateFlight = "label.title_return_date".localized
    static let timeTitle = "label.title_time".localized
    static let titleAttractionView = "title.attraction_view".localized
    static let titleHotelView = "title.hotel_view".localized
    static let titleRestaurantView = "title.restaurant_view".localized
    static let titleTicketView = "title.ticket_view".localized
    static let tripTitle = "label.title_trip".localized
    static let users = "title.users".localized
    static let welcomeLabelTitle = "label.tile_welcome".localized
    
    //MARK: Symbols
    static let atSymbol = "at_symbol".localized
    static let dotCom = "dot_com".localized
    
    //MARK: Placeholders
    static let calendarOnGoingPlaceholderFlight = "flight.calendarOnGoing_placeholder".localized
    static let calendarOutGoingPlaceholderFlight = "flight.alendarOutGoing_placeholder".localized
    static let confirmPasswordPlaceholder = "registration.confirm_password_placeholder".localized
    static let destinationPlaceholderFlight = "flight.destination_placeholder".localized
    static let emailPlaceholder = "registration.email_placeholder".localized
    static let emailPlaceholderProfile = "prifile.email_exemple".localized
    static let emailAlreadyExist = "registration.newaccount_error".localized
    static let namePlaceholder = "registration.name_placeholder".localized
    static let namePlaceholderProfile = "profile.name_text".localized
    static let originPlaceholderFight = "flight.origin_placeholder".localized
    static let passengersPlaceholderFlight = "flight.passengers_placeholder".localized
    static let passwordPlaceholder = "registration.password_placeholder".localized
    static let searchPlaceholderAttraction = "attraction.search_placeholder".localized
    static let searchPlaceholderHotel = "hotel.search_placeholder".localized
    static let searchPlaceholderRestaurant = "restaurant.search_placeholder".localized
    static let titleLabelFight = "flight.label_title".localized
    
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
