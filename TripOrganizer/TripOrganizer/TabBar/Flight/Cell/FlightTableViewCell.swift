//
//  FlightTableViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 17/03/23.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outboundAirlinerLabel: UILabel!
    @IBOutlet weak var returnAirlinerLabel: UILabel!
    
    @IBOutlet weak var outboundAirportDepartureLabel: UILabel!
    @IBOutlet weak var outboundAirportArrivalLabel: UILabel!
    
    @IBOutlet weak var outboundDepTimeLabel: UILabel!
    @IBOutlet weak var outboundArrivelTimeLabel: UILabel!
    
    @IBOutlet weak var returnDepTimeLabel: UILabel!
    @IBOutlet weak var returnArrivalTimeLabel: UILabel!
    
    @IBOutlet weak var returnAirportDepLabel: UILabel!
    @IBOutlet weak var returnAirportArrivalLabel: UILabel!
    
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
    
    func setupCell(ongoingCiaName: String, outgoingCiaName: String, ongoingDeparture: String, ongoingArrival: String, outgoingDeparture: String, outgoingArrival: String, priceWithoutTax: Double, priceWithTax: Double, originDepTime: String, originArrivalTime: String, returnDepTime: String, returnArrivalTime: String) {

        outboundAirlinerLabel.text = ongoingCiaName
        returnAirlinerLabel.text = outgoingCiaName
        
        outboundAirportDepartureLabel.text = ongoingDeparture
        outboundAirportArrivalLabel.text = ongoingArrival
        
        returnAirportDepLabel.text = outgoingDeparture
        returnAirportArrivalLabel.text = outgoingArrival
        
        totalPriceWithoutTaxLabel.text = String(priceWithoutTax)
        totalPriceWithTaxesLabel.text = String(priceWithTax)
        
        outboundDepTimeLabel.text = originDepTime
        outboundArrivelTimeLabel.text = originArrivalTime
        returnDepTimeLabel.text = returnDepTime
        returnArrivalTimeLabel.text = returnArrivalTime
        
    }
    
}
