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

    override func awakeFromNib() {
        super.awakeFromNib()
        configCellLayout()
        configCellItemsLayout()
    }
    
    
    public func setupCell(place: ProtocolObject) {
        placeNameLabel.text = place.name
        placeAddressLabel.text = place.address
        placePhoneLabel.text = place.phoneNumber
        openingHoursLabel.text = place.openingHours
        //        placeNameLabel.text = place.name
//        placeAddressLabel.text = place.address
//        placePhoneLabel.text = place.phoneNumber
//        openingHoursLabel.text = place.openingHours
//        //  placeImageView.image = UIImage(named: place.images)
//        placeNameLabel.text = placeHotel.name
//        placeAddressLabel.text = placeHotel.address
//        placePhoneLabel.text = placeHotel.phoneNumber
//        openingHoursLabel.text = placeHotel.openingHours
       
            // Converta a representação de dados em uma instância de UIImage
        let image = UIImage(data: place.images)
            // Exiba a imagem em uma UIImageView
            placeImageView.image = image
        
//  placeImageView.image = UIImage(named: place.images[0])
    }
    
    private func configCellLayout() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
    }
    
    private func configCellItemsLayout() {
        placeImageView.clipsToBounds = true
        placeImageView.layer.cornerRadius = 20
        openingHoursLabel.clipsToBounds = true
        closingHoursLabel.clipsToBounds = true
        openingHoursLabel.layer.cornerRadius = 3
        closingHoursLabel.layer.cornerRadius = 5
        openingHoursLabel.textColor = .white
        closingHoursLabel.textColor = .white
        openingHoursLabel.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
        closingHoursLabel.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
    }
}
