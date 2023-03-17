//
//  FlightTableViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 17/03/23.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ongoingAirlinerLabel: UILabel!
    @IBOutlet weak var outgoingAirlinerLabel: UILabel!
    
    @IBOutlet weak var ongoingDepartureLabel: UILabel!
    @IBOutlet weak var ongoingArrivalLabel: UILabel!
    
    @IBOutlet weak var outgoingDepartureLabel: UILabel!
    @IBOutlet weak var outgoingArrivalLabel: UILabel!
    
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var totalPriceWithoutTaxLabel: UILabel!
    @IBOutlet weak var totalPriceWithTaxesLabel: UILabel!
    
    @IBOutlet weak var adittionalInfoLabel: UILabel!
    
    static let identifier: String = "FlightTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(ongoingCiaName: String, outgoingCiaName: String, ongoingDeparture: String, ongoingArrival: String, outgoingDeparture: String, outgoingArrival: String, priceWithoutTax: Double, priceWithTax: Double) {

        ongoingAirlinerLabel.text = ongoingCiaName
        outgoingAirlinerLabel.text = outgoingCiaName
        
        ongoingDepartureLabel.text = ongoingDeparture
        ongoingArrivalLabel.text = ongoingArrival
        
        outgoingDepartureLabel.text = outgoingDeparture
        outgoingArrivalLabel.text = outgoingArrival
        
        totalPriceWithoutTaxLabel.text = String(priceWithoutTax)
        totalPriceWithTaxesLabel.text = String(priceWithTax)
        
    }
    
}
