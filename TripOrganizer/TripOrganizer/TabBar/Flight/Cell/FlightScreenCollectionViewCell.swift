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
    
    static let identifier: String = "FlightScreenCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
         cityImageView.contentMode = .scaleAspectFill
    }
    
    func setupCell(cityName: String, cityImage: String, cityDescription: String) {
       
        cityNameLabel.text = cityName
        cityDescriptionLabel.text = cityDescription
        cityImageView.image = UIImage(named: cityImage)
    }

}
