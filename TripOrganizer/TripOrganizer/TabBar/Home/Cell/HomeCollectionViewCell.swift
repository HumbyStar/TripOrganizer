//
//  HomeCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    @IBOutlet var placeType: UILabel!
    @IBOutlet var placesCollectionView: UICollectionView!
    
    
    static public func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        
        if let layout = placesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        
        placesCollectionView.register(PlacesCollectionViewCell.nib(), forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
    }

}


extension HomeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlacesCollectionViewCell? = placesCollectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as? PlacesCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }
}
