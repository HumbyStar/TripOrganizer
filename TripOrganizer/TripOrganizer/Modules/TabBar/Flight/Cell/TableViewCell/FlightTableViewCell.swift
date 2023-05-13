//
//  FlightTableViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    public static let identifier: String = String(describing: FlightTableViewCell.self)
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupCell(objectPassages: FlightModel){
        
    }
}
