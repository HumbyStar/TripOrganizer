//
//  FlightTableViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
   public static let identifier: String = "FlightTableViewCell"
    
   public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupCell(objectPassages: FlightModel){
        
    }
}
