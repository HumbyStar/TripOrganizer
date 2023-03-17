//
//  LoungeVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class AttractionVC: UIViewController {
    
    let locationImagelist: [String] = ["1","2","3","4","5"]

    @IBOutlet var mapView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var map: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var detailView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configViewStyle()
        //configMapShadow()
        configDetailViewShadow()
        configSearchBarShadowBar()
    }
    
    func configViewStyle() {
        detailView.layer.borderWidth = 3.0
        detailView.layer.borderColor = UIColor.white.cgColor
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 15
        
        mapView.layer.borderWidth = 3.0
        mapView.layer.borderColor = UIColor.white.cgColor
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 15
        
        collectionView.backgroundColor = .clear
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
        
    }
    
    func configDetailViewShadow() {
        detailView.layer.shadowColor = UIColor.black.cgColor
        detailView.layer.shadowOpacity = 0.5
        detailView.layer.shadowOffset = CGSize(width: 0, height: 2)
        detailView.layer.shadowRadius = 4
        detailView.layer.masksToBounds = false
    }
    
    
    func configMapShadow() {
        mapView.layer.shadowColor = UIColor.black.cgColor
        mapView.layer.shadowOpacity = 0.5
        mapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mapView.layer.shadowRadius = 1
        mapView.layer.masksToBounds = false
        
    }
    
    func configSearchBarShadowBar() {
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.5
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchBar.layer.shadowRadius = 4
        searchBar.layer.masksToBounds = false
    }
    
    
    
    func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        
        collectionView.register(AttractionCell.nib(), forCellWithReuseIdentifier: AttractionCell.identifier)
    }
}

extension AttractionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationImagelist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AttractionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionCell.identifier, for: indexPath) as? AttractionCell
        cell?.setupCell(imageName: locationImagelist[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
}
