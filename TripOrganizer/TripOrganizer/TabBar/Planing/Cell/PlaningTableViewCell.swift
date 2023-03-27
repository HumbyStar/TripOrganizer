//
//  PlaningTableViewCell.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 22/03/23.
//

import UIKit

class PlaningTableViewCell: UITableViewCell {
    @IBOutlet weak var ivPerfilPlace: UIImageView!
    @IBOutlet weak var lbPlace: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbAdress: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
