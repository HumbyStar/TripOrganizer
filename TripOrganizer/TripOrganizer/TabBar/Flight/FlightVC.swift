//
//  FlightVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

class FlightVC: UIViewController {
    
    private var ongoingAirlinerList: [String] = ["GOL", "AZUL", "GOL", "AZUL"]
    private var outgoingAirlinerList: [String] = ["TAM", "GOL", "TAM", "GOL"]
    
    private var ongoingDepartureList: [String] = ["GIG", "GRU", "GIG", "GRU"]
    private var ongoingArrivalList: [String] = ["GRU", "GIG", "GRU", "GIG"]
    
    private var outgoingDepartureList: [String] = ["VCP", "BSB", "VCP", "BSB"]
    private var outgoingArrivalList: [String] = ["BSB", "VCP", "BSB", "VCP"]
    
    private var priceWithoutTaxList: [Double] = [500.50, 865.92, 3123, 1223]
    private var priceWithTaxList: [Double] = [1238.2, 321.23, 6783, 1980]
    
    private var outboundDepTime: [String] = ["23:00", "22:00", "21:00", "17:00"]
    private var outboundArrivalTime: [String] = ["23:50", "22:50", "21:50", "17:50"]
    
    private var returnDepTime: [String] = ["10:00", "11:00", "07:00", "17:00"]
    private var returnArrTime: [String] = ["10:50", "11:50", "07:50", "17:50"]
    
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
    @IBOutlet weak var flightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
        configTableView()
    }
    
    private func configTableView() {
        flightTableView.dataSource = self
        flightTableView.delegate = self
        flightTableView.register(FlightTableViewCell.nib(), forCellReuseIdentifier: FlightTableViewCell.identifier)
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

extension FlightVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ongoingAirlinerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell
        cell?.setupCell(ongoingCiaName: ongoingAirlinerList[indexPath.row], outgoingCiaName: outgoingAirlinerList[indexPath.row], ongoingDeparture: ongoingDepartureList[indexPath.row], ongoingArrival: ongoingArrivalList[indexPath.row], outgoingDeparture: outgoingDepartureList[indexPath.row], outgoingArrival: outgoingArrivalList[indexPath.row], priceWithoutTax: priceWithoutTaxList[indexPath.row], priceWithTax: priceWithTaxList[indexPath.row], originDepTime: outboundDepTime[indexPath.row], originArrivalTime: outboundArrivalTime[indexPath.row], returnDepTime: returnDepTime[indexPath.row], returnArrivalTime: returnArrTime[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    
}
