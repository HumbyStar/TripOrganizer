//
//  CollectionViewCell.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 27/03/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photosImageView: UIImageView!
    @IBOutlet weak var valuesLabel: UILabel!
    
    static let identifier = "CollectionViewCell"
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(values: String) {
//        photosImageView.image = UIImage(named: imageName)
        valuesLabel.text = values
    }
    
}

