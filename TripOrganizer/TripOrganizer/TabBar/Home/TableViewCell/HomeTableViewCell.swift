//
//  HomeTableViewCell.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 09/04/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    static let identifier: String = "HomeTableViewCell"
    
    static public func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var placeName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        homeCollectionView.showsHorizontalScrollIndicator = false
        configCollectionViewCell()
    }
    
    private func configCollectionViewCell() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        homeCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    public func setupCell(placeType: String) {
        placeName.text = placeType
        placeName.font = UIFont.boldSystemFont(ofSize: 20)
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
