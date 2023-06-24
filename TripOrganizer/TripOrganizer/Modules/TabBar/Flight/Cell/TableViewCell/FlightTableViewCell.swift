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
    
    public func setupCell(data: Ticket?) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let departure = formatter.date(from: data?.legs?[0].departure ?? "")
        let arrival = formatter.date(from: data?.legs?[0].arrival ?? "")
        let departureReturn = formatter.date(from: data?.legs?[1].departure ?? "")
        let arrivalReturn = formatter.date(from: data?.legs?[1].arrival ?? "")
        
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.init(identifier: "pt-br")
        
        if let departure {
            departureTimeLabel.text = formatter.string(from: departure)
        }
        
        if let arrival {
            arrivalTimeLabel.text = formatter.string(from: arrival)
        }
        
        if let departureReturn {
            departureTimeReturnTripLabel.text = formatter.string(from: departureReturn)
        }
        
        if let arrivalReturn {
            arrivalTimeReturnTripLabel.text = formatter.string(from: arrivalReturn)
        }
        
        departurePlaceLabel.text = data?.legs?[0].origin?.name
        arrivalPlaceLabel.text = data?.legs?[0].destination?.name
        travelDurationLabel.text = "\(data?.legs?[0].duration ?? 0) minutos"
        flightPriceLabel.text = "R$:\(data?.price?.amount ?? 0.0)"
        
        // Se você tem dados de viagem de retorno, configure-os também
        departurePlaceReturnTripLabel.text = data?.legs?[1].origin?.name
        arrivalPlaceReturnTripLabel.text = data?.legs?[1].destination?.name
        TravelDurationReturnTripLabel.text = "\(data?.legs?[1].duration ?? 0) minutos"
    }
    
}
