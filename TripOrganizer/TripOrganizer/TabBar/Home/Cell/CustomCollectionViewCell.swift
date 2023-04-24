//
//  CustomCollectionViewCell.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 21/04/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var horario1: UILabel!
    @IBOutlet var horario2: UILabel!
    
    static let identifier: String = String(describing: CustomCollectionViewCell.self)
    
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
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        placeImageView.clipsToBounds = true
        placeImageView.layer.cornerRadius = 20
        horario1.clipsToBounds = true
        horario2.clipsToBounds = true
        horario1.layer.cornerRadius = 5
        horario2.layer.cornerRadius = 5
        horario1.textColor = .white
        horario2.textColor = .white
        horario1.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
        horario2.backgroundColor = UIColor(red: 112/255, green: 155/255, blue: 149/255, alpha: 1.0)
    }
    
}
