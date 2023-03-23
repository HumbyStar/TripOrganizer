//
//  HoteisCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 23/03/23.
//

import UIKit

class HoteisCollectionViewCell: UICollectionViewCell {

    static let identifier = "HoteisCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configCell() {
        
    }
}
