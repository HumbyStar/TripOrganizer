//
//  HotelCollectionViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 12/04/23.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HotelCollectionViewCell"
    
    var hotelList: [String] = ["imagehotel", "hotel1", "hotel2"]
    
    static public func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hotelCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        hotelCollectionView.delegate = self
        hotelCollectionView.dataSource = self
        
        if let layout = hotelCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        hotelCollectionView.register(PlacesCollectionViewCell.nib(), forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        
        hotelCollectionView.showsHorizontalScrollIndicator = false
    }
    
    public func setupCell(placeType: String) {
        self.nameLabel.text = placeType
        self.nameLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
}

extension HotelCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlacesCollectionViewCell? = hotelCollectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as? PlacesCollectionViewCell
        cell?.setupCell(imageName: hotelList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height)
    }
}
