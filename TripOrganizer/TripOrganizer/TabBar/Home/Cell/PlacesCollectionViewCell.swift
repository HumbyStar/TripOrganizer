//
//  PlacesCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var placesImage: UIImageView!
    
    static let identifier: String = "PlacesCollectionViewCell"
    
    static public func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
