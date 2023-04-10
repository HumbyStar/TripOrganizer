//
//  PlacesCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PlacesCollectionViewCell"
    
    static public func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet var placeImageView: UIImageView!
    
    public func setupCell(imageName: String) {
        placeImageView.image = UIImage(named: imageName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
