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
    
    @IBOutlet var addTripButton: UIButton!
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var finishDate: UIDatePicker!
    
    var startDateString: String?
    var finishDateString: String?
    
    var delegate: AddTripviewControllerDelegate?
    
    public func delegate(delegate: AddTripviewControllerDelegate) {
        self.delegate = delegate
    }
    
    @IBOutlet var tripNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTripNameTextField()
        configAddTripButton()
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
    
    
    @IBAction func addTripButtonPressed(_ sender: UIButton) {
        
        if let name = tripNameTextField.text {
            self.delegate?.sendTrip(trip: Trip(tripName: name, startDate: startDateString ?? "", finishDate: finishDateString ?? ""))
            navigationController?.popViewController(animated: true)
        }

    }
}
