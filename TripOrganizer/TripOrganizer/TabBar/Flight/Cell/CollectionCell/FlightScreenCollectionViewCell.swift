//
//  FlightScreenCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class FlightScreenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
   public static let identifier: String = "FlightScreenCollectionViewCell"
    
   public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
         cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 12
        cityImageView.clipsToBounds = true
    }
    
   public func setupCell(cityObject: FlightModel) {
        cityNameLabel.text = cityObject.cityNameObject
        cityDescriptionLabel.text = cityObject.cityDescriptionObject
        cityImageView.image = UIImage(named: cityObject.cityImageObject)
    }

}
