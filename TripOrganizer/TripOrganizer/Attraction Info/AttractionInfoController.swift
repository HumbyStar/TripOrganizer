//
//  AttractionInfoController.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 20/03/23.
//

import UIKit
import MapKit

class AttractionInfoController: UIViewController {
    
    var attractionImageList: [String] = ["1", "2", "3", "4", "5"]

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var map: MKMapView!
    @IBOutlet var attractionImageLabel: UILabel!
    @IBOutlet var attractionNameLabel: UILabel!
    @IBOutlet var attractionAdressLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configCollectionView()
    }
    
    private func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        
        self.collectionView.register(AttractionInfoCell.nib(), forCellWithReuseIdentifier: AttractionInfoCell.identifier)
    }
}

extension AttractionInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AttractionInfoCell? = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionInfoCell.identifier, for: indexPath) as? AttractionInfoCell
        cell?.setupCell(imageName: attractionImageList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
}
