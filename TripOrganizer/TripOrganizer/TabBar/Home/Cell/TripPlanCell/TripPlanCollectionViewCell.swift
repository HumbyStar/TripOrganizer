//
//  CustomCollectionViewCell.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 21/04/23.
//

import UIKit

class TripPlanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var placeAddressLabel: UILabel!
    @IBOutlet var placePhoneLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    @IBOutlet var closingHoursLabel: UILabel!
    
    static let identifier: String = String(describing: TripPlanCollectionViewCell.self)
    
    static public func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func layoutSubviews() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    public func setupCell(place: TripPlan) {
        placeNameLabel.text = place.placeName
        placeImageView.image = UIImage(named: place.placeImageName)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        placeImageView.clipsToBounds = true
        placeImageView.layer.cornerRadius = 20
        openingHoursLabel.clipsToBounds = true
        closingHoursLabel.clipsToBounds = true
        openingHoursLabel.layer.cornerRadius = 5
        closingHoursLabel.layer.cornerRadius = 5
        openingHoursLabel.textColor = .white
        closingHoursLabel.textColor = .white
        openingHoursLabel.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
        closingHoursLabel.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
    }
    
}
