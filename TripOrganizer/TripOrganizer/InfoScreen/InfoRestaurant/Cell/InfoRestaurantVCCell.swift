//
//  InfoRestaurantVCCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 27/03/23.
//

import UIKit

class InfoRestaurantVCCell: UICollectionViewCell {
    
    static let identifier: String = "InfoRestaurantVCCell"
    static func nib()-> UINib{
        return UINib(nibName: identifier, bundle: nil)
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
    }
}







