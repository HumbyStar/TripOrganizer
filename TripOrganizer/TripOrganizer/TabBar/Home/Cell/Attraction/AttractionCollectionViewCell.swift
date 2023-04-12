//
//  HomeCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class AttractionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var placesCollectionView: UICollectionView!
    @IBOutlet var placeType: UILabel!
    
    static let identifier: String = "AttractionCollectionViewCell"
    
    var attractionList: [String] = ["parque", "parque1", "1", "2", "3", "4", "5"]
    
    static public func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionview()
    }
    
    private func configCollectionview() {
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        
        if let layout = placesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        placesCollectionView.register(PlacesCollectionViewCell.nib(), forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        
        placesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    public func setupCell(placeType: String) {
        self.placeType.text = placeType
        self.placeType.font = UIFont.systemFont(ofSize: 18)
    }

}

extension AttractionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlacesCollectionViewCell? = placesCollectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as? PlacesCollectionViewCell
        cell?.setupCell(imageName: attractionList[indexPath.row])
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height)

    }
    
}
