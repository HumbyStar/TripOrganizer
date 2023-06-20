//
//  FlightTableViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//


//public let cityNameObject: String
//public let cityDescriptionObject: String
//public let cityImageObject: String
//public let ticketPrice: String
//public let tripDuration: String
//public let tripStartTime: String
//public let tripEndTime: String
//public let locateOrigin: String
//public let locateDestination: String

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak var departurePlaceLabel: UILabel!
    
    @IBOutlet weak var arrivalPlaceLabel: UILabel!
    
    @IBOutlet weak var travelDurationLabel: UILabel!
    
    @IBOutlet weak var flightPriceLabel: UILabel!
    
    @IBOutlet weak var departureTimeReturnTripLabel: UILabel!
    
    @IBOutlet weak var arrivalTimeReturnTripLabel: UILabel!
    
    @IBOutlet weak var departurePlaceReturnTripLabel: UILabel!
    
    @IBOutlet weak var arrivalPlaceReturnTripLabel: UILabel!
    
    @IBOutlet weak var TravelDurationReturnTripLabel: UILabel!
    
    public static let identifier: String = String(describing: FlightTableViewCell.self)
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupCell(data: Ticket) {
        departureTimeLabel.text = data.legs[0].departure
        arrivalTimeLabel.text = data.legs[0].arrival
        departurePlaceLabel.text = data.legs[0].departure
        arrivalPlaceLabel.text = data.legs[0]
        travelDurationLabel.text = data.travelDuration
        flightPriceLabel.text = data.flightPrice
        
    }
}

//let priceString = String(flights[0].price.amount)
//self.priceLabel.text = "Valor: \(priceString)"
//
//let originString = String(flights[0].legs[0].origin.name)
//self.airportOriginLabel.text = "Origem: \(originString)"
//
//let destinString = String(flights[0].legs[0].destination.name)
//self.airportDestinationLabel.text = "Destino: \(destinString)"
//
//let carrierString = String(flights[0].legs[0].carriers[0].name)
//self.carrierLabel.text = "Compania: \(carrierString)"
//
//let departureString = String(flights[0].legs[0].departure)
//self.departureLabel.text = "Saida: \(departureString)"
//
//let arrivalString = String(flights[0].legs[0].arrival)
//self.arrivalLabel.text = "Chegada: \(arrivalString)"
//
//let durationString = String(flights[0].legs[0].duration)
//self.flightDurationLabel.text = "Duração: \(durationString)"
//
//// VOLTA
//let priceString2 = String(flights[0].price.amount)
//self.priceLabel2.text = "Valor: \(priceString2)"
//
//let originString2 = String(flights[0].legs[1].origin.name)
//self.airportOriginLabel2.text = "Origem: \(originString2)"
//
//let destinString2 = String(flights[0].legs[1].destination.name)
//self.airportDestinationLabel2.text = "Destino: \(destinString2)"
//
//let carrierString2 = String(flights[0].legs[1].carriers[0].name)
//self.carrierLabel2.text = "Compania: \(carrierString2)"
//
//let departureString2 = String(flights[0].legs[1].departure)
//self.departureLabel2.text = "Saida: \(departureString2)"
//
//let arrivalString2 = String(flights[0].legs[1].arrival)
//self.arrivalLabel2.text = "Chegada: \(arrivalString2)"
//
//let durationString2 = String(flights[0].legs[1].duration)
//self.flightDurationLabel2.text = "Duração: \(durationString2)"
