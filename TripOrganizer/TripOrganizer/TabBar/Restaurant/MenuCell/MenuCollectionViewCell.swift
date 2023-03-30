//
//  MenuCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 24/03/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var figuraImageView: UIImageView!
    @IBOutlet weak var fotoImageView: UIImageView!
    
    static let identifier: String = "MenuCollectionViewCell"
             
    static func nib() -> UINib {
        return UINib.init(nibName: identifier, bundle: nil)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        // Initialization code
    }
    func setupCell(image: String, valor:String){
        fotoImageView.image = UIImage(named: image)
        valorLabel.text = valor
        fotoImageView.layer.cornerRadius = 10
    }
    
    
    
}
