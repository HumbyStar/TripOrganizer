//
//  AttractionCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 16/03/23.
//

import UIKit

class AttractionCell: UICollectionViewCell {
    @IBOutlet var attractionImageView: UIImageView!
    
    lazy var skeletionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    public static let identifier: String = String(describing: AttractionCell.self)
    
    public static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attractionImageView.contentMode = .scaleAspectFill
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
        attractionImageView.image = image
        attractionImageView.layer.cornerRadius = 10
    }
    
}
