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
    
    public static let identifier: String = String(describing: FlightScreenCollectionViewCell.self)
    
    public static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configImageView()
    }
    
    private func configImageView() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 12
        cityImageView.clipsToBounds = true
    }
    
    public func setupCell(cityObject: Flight) {
        cityNameLabel.text = cityObject.cityNameObject
        cityDescriptionLabel.text = cityObject.cityDescriptionObject
        cityImageView.image = UIImage(named: cityObject.cityImageObject)
    }
    
}
