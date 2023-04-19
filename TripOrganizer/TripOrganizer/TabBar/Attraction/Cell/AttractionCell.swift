//
//  AttractionCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 16/03/23.
//

import UIKit

class AttractionCell: UICollectionViewCell {
    
    @IBOutlet var attractionImageView: UIImageView!
    
    static let identifier: String = "AttractionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        attractionImageView.contentMode = .scaleAspectFill
    }
    
    func setupCell(imageName: AttractionModel) {
        self.attractionImageView.image = UIImage(named: imageName.name)
    }

}
