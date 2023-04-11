//
//  FlightVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

class FlightVC: UIViewController {
    
    @IBOutlet weak var chooseADestinationLabel: UILabel!
    @IBOutlet weak var flightOriginView: UIView!
    @IBOutlet weak var flightOriginTextField: UITextField!
    @IBOutlet weak var calendarOnGoingView: UIView!
    @IBOutlet weak var calendarOnGoingTextField: UITextField!
    @IBOutlet weak var calendarOutGoingView: UIView!
    @IBOutlet weak var calendarOutGoingTextField: UITextField!
    @IBOutlet weak var flightDestinationView: UIView!
    @IBOutlet weak var flightDestinationTextField: UITextField!
    @IBOutlet weak var passengersView: UIView!
    @IBOutlet weak var passengersTextField: UITextField!
    @IBOutlet weak var ticketSearchButton: UIButton!
    @IBOutlet weak var airTicketsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
    }
    
    private func configElements() {
        
        flightOriginTextField.borderStyle = .none
        flightDestinationTextField.borderStyle = .none
        calendarOnGoingTextField.borderStyle = .none
        calendarOutGoingTextField.borderStyle = .none
        passengersTextField.borderStyle = .none
        
        chooseADestinationLabel.text = "Vamos escolher um lugar de destino?"
        
        flightOriginTextField.placeholder = "Escolha a origem"
        flightDestinationTextField.placeholder = "Escolha o destino"
        
        calendarOnGoingTextField.placeholder = "Ida"
        calendarOutGoingTextField.placeholder = "Retorno"
        
        passengersTextField.placeholder = "Quantos passageiros?"
       
        let font = UIFont.systemFont(ofSize: 15)
        let atributos: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let textoComFonte = NSAttributedString(string: "Buscar passagens", attributes: atributos)
        ticketSearchButton.setAttributedTitle(textoComFonte, for: .normal)
        
        airTicketsLabel.text = "Passagens de avião"
        
        flightOriginView.layer.cornerRadius = 5
        flightOriginView.clipsToBounds = true
        flightDestinationView.layer.cornerRadius = 5
        flightDestinationView.clipsToBounds = true
        calendarOnGoingView.layer.cornerRadius = 5
        calendarOnGoingView.clipsToBounds = true
        calendarOutGoingView.layer.cornerRadius = 5
        calendarOutGoingView.clipsToBounds = true
        passengersView.layer.cornerRadius = 5
        passengersView.clipsToBounds = true
        ticketSearchButton.layer.cornerRadius = 5
        ticketSearchButton.clipsToBounds = true

    }

}
    

