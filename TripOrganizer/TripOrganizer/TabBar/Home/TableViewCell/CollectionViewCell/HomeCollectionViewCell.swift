//
//  HomeCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var placeImageView: UIImageView!
    
    static let identifier: String = "HomeCollectionViewCell"
    
    static public func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupCell(placeImageName: String) {
        placeImageView.image = UIImage(named: placeImageName)
    }
}
