//
//  AttractionCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 16/03/23.
//

import UIKit

class AttractionCell: UICollectionViewCell {
    
    @IBOutlet var attractionImageView: UIImageView!
    
    public static let identifier: String = String(describing: AttractionCell.self)
    
    public static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attractionImageView.contentMode = .scaleAspectFill
    }
    
    func setupCell(image: String){
        attractionImageView.image = UIImage(named: image)
        attractionImageView.layer.cornerRadius = 10
    }
    
}
