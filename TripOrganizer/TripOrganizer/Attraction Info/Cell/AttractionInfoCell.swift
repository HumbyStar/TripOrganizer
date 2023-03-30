//
//  AttractionInfoCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 20/03/23.
//

import UIKit

class AttractionInfoCell: UICollectionViewCell {
    
    static let identifier: String = "AttractionInfoCell"
    
    @IBOutlet var attractionImageView: UIImageView!
   
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func setupCell(imageName: String) {
        attractionImageView.image = UIImage(named: imageName)
        attractionImageView.contentMode = .scaleAspectFill
    }
    
    
}
