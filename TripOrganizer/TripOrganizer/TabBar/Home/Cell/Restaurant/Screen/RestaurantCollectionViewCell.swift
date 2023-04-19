//
//  RestaurantCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 12/04/23.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var restaurantCollectionView: UICollectionView!
    
    var viewModel: RestaurantCellViewModel = RestaurantCellViewModel()
    
    static let identifier: String = "RestaurantCollectionViewCell"
    
    static public func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
        
        if let layout = restaurantCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        restaurantCollectionView.register(PlacesCollectionViewCell.nib(), forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        
        restaurantCollectionView.showsHorizontalScrollIndicator = false
    }
    
    public func setupCell(placeType: String) {
        self.nameLabel.text = placeType
        self.nameLabel.font = UIFont.systemFont(ofSize: 18)
    }
}

extension RestaurantCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getRestautantListSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlacesCollectionViewCell? = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as? PlacesCollectionViewCell
        cell?.setupCell(imageName: viewModel.getImage(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height)
    }
    
}
