//
//  InfoHoteisViewController.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 24/03/23.
//

import UIKit

class InfoHoteisViewController: UIViewController {
    
    @IBOutlet weak var photosImageView: UIImageView!
    @IBOutlet weak var nameHotelLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var listPhotos: [String] = ["infoquarto1", "infoquarto2", "infoquarto3","infoquarto1", "infoquarto2", "infoquarto3"]
    private var listValues: [String] = ["R$:200", "R$250", "R$300","R$200", "R$250", "R$300"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configButton()
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    private func configButton() {
        
    }
}


extension InfoHoteisViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        cell?.photosImageView.image = UIImage(named: listPhotos[indexPath.row])
        cell?.setupCell(values: listValues[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 135)
    }
}
