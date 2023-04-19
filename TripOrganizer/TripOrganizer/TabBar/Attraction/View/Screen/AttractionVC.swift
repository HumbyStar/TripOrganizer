//
//  LoungeVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class AttractionVC: UIViewController {
    
    
  public let viewModel: AttractionViewModel = AttractionViewModel()
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var map: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var detailView: UIView!
    @IBOutlet var addAttractionButton: UIButton!
    @IBOutlet var attractionNameLabel: UILabel!
    @IBOutlet var attractionAdressLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var entranceFeeLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        roundedBorder()

    }
    
    private func roundedBorder() {
        detailView.layer.cornerRadius = 12
        map.layer.cornerRadius = 12
    }
    
    
private func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        viewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(AttractionCell.nib(), forCellWithReuseIdentifier: AttractionCell.identifier)
        collectionView.backgroundColor = .clear
    }
}

extension AttractionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getLocationImagelist()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AttractionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionCell.identifier, for: indexPath) as? AttractionCell
        cell?.setupCell(imageName: viewModel.getLocationImageListCellForItemAt(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(IndexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
        
    }
    
    
}
