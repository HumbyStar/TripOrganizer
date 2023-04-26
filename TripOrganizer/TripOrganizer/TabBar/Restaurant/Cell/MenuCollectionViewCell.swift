//
//  MenuCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 24/03/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    
    static let identifier: String = "MenuCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(image: String){
        menuItemImageView.image = UIImage(named: image)
        menuItemImageView.layer.cornerRadius = 10
    }
    
}
