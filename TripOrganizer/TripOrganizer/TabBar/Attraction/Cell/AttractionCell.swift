//
//  AttractionCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 16/03/23.
//

import UIKit

class AttractionCell: UICollectionViewCell {
    
    @IBOutlet var attractionImageView: UIImageView!
    
  public static let identifier: String = "AttractionCell"
    
 public static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        attractionImageView.contentMode = .scaleAspectFill
    }
    
   public func setupCell(imageName: AttractionModel) {
        self.attractionImageView.image = UIImage(named: imageName.imageAttraction)
    }

}
