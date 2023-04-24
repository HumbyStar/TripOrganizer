//
//  CustomTableViewCell.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 22/04/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var finishDateLabel: UILabel!
    
    static let indentifier: String = String(describing: CustomTableViewCell.self)
    
    static public func nib() -> UINib {
        return UINib(nibName: self.indentifier, bundle: nil)
    }
    
    override func layoutSubviews() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
        self.placeImageView.clipsToBounds = true
        self.placeImageView.layer.cornerRadius = 8
    }
    
    public func setupCell(trip: Trip) {
        tripNameLabel.text = trip.tripName
        startDateLabel.text = trip.startDate
        finishDateLabel.text = trip.finishDate
    }
    
}
