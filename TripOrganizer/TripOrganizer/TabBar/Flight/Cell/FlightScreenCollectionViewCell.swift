//
//  FlightScreenCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class FlightScreenCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "FlightScreenCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // logoImageVIew.contentMode = .scaleAspectFit
    }
    
//    func setupCell(image: String, name: String) {
//        logoImageVIew.image = UIImage(named: image)
//        nameCompanyLabel.text = name
//    }

}
