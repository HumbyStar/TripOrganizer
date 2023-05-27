//
//  MenuCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 24/03/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    
    static let identifier: String = String(describing: MenuCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuItemImageView.contentMode = .scaleAspectFill
    }
    
    func setupCell(image: String){
        menuItemImageView.image = UIImage(named: image)
        menuItemImageView.layer.cornerRadius = 10
    }
    
}
