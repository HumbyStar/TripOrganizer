//
//  HoteisCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 23/03/23.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var skeletionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    public var data: [HotelModel] = []
    
    static let identifier = String(describing: HotelCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
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
        imageView.image = image
        imageView.layer.cornerRadius = 10
    }
    
}
