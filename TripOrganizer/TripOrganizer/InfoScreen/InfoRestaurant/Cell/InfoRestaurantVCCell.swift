//
//  InfoRestaurantVCCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 27/03/23.
//

import UIKit

class InfoRestaurantVCCell: UICollectionViewCell {
    
    @IBOutlet weak var adicionarButton: UIButton!
    @IBOutlet weak var cardapioValorLabel: UILabel!
    @IBOutlet weak var cardapioFotoImageView: UIImageView!
    static let identifier: String = "InfoRestaurantVCCell"
    static func nib()-> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            }
        
    func setupCell(image: String, valor:String){
            cardapioFotoImageView.image = UIImage(named: image)
            cardapioValorLabel.text = valor
            
        }
    }
    






