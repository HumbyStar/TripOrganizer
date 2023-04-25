//
//  AddTripViewController.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 22/04/23.
//

import UIKit

protocol AddTripviewControllerDelegate {
    func sendTrip(trip: Trip)
}

class AddTripViewController: UIViewController {
    
    var alert: Alert?
    
    @IBOutlet var tripNameTextField: UITextField!
    @IBOutlet var addTripButton: UIButton!
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var finishDate: UIDatePicker!
    @IBOutlet var backButton: UIButton!
    
    var startDateString: String?
    var finishDateString: String?
    
    var delegate: AddTripviewControllerDelegate?
    
    public func delegate(delegate: AddTripviewControllerDelegate) {
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configTripNameTextField()
        configAddTripButton()
        configBackButton()
        configStartDate()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func configTripNameTextField() {
        tripNameTextField.clipsToBounds = true
        tripNameTextField.layer.cornerRadius = 16
        tripNameTextField.borderStyle = .roundedRect
    }
    
    func configAddTripButton() {
        addTripButton.clipsToBounds = true
        addTripButton.layer.cornerRadius = 16
    }
    
    func configBackButton() {
        backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white
    }
    
    func configStartDate() {
//        startDate
    }
    
    @IBAction func startDateAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let selectedDate = sender.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        self.startDateString = formattedDate
    }
    
    
    @IBAction func finishDateAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let selectedDate = sender.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        self.finishDateString = formattedDate
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addTripButtonPressed(_ sender: UIButton) {
        
        if tripNameTextField.hasText {
            guard let name = tripNameTextField.text else { return }
            self.delegate?.sendTrip(trip: Trip(tripName: name, startDate: startDateString ?? "", finishDate: finishDateString ?? ""))
            navigationController?.popViewController(animated: true)
        } else {
            self.alert?.createAlert(title: "Trip Organizer", message: "Sua viagem deve conter um nome!")
        }
    }
}
