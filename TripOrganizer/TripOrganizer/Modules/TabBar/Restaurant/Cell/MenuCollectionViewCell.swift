//
//  MenuCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 24/03/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    
    lazy var skeletionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    static let identifier: String = String(describing: MenuCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib.init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuItemImageView.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        addSubview(skeletionView)
        skeletionView.frame = bounds
    }
    
    func showSkeleton() {
        skeletionView.isHidden = false
    }
    
    func hideSkeleton() {
        skeletionView.isHidden = true
    }
    
    func setupCell(image: UIImage){
        menuItemImageView.image = image
        menuItemImageView.layer.cornerRadius = 10
    }
    
}
