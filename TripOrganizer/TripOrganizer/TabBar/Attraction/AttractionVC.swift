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
        configSearchBarStyle()
        configMapViewBorder()
        configDetailViewBorder()
        configMapViewShadow()
        configMapConstraints()
        configDetailViewShadow()
        configSearchBarShadowBar()
    }
    
    func configSearchBarStyle() {
        
        collectionView.backgroundColor = .clear
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
        
    }
    
    public func configMapConstraints() {
        let heightConstraint = mapView.heightAnchor.constraint(equalToConstant: 270)
        heightConstraint.isActive = true

        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: // iPhone SE (1st generation), iPhone 5, iPhone 5S, iPhone 5C
                heightConstraint.constant = 150
            case 1334, 1920, 2208: // iPhone 6, 6S, 7, 8, SE (2nd generation)
                heightConstraint.constant = 270
            case 2436, 2688, 1792: // iPhone X, XS, XR, 11 Pro, 12 mini, 11, 12
                heightConstraint.constant = 300
            case 2778: // IPhone 14 Plus
                heightConstraint.constant = 400
            case 2532: // iPhone 14
                heightConstraint.constant = 350
            default: // IPhone Pro Max
                heightConstraint.constant = 400 // default value for other devices
                // IPhone 14 pro?
            }
        }
    }
    
    func configDetailViewBorder() {
//      detailView.layer.borderWidth = 3.0 -> a borda fica por cima do botão.
        detailView.layer.borderColor = UIColor.white.cgColor
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 15
    }
    
    func configDetailViewShadow() {
        detailView.layer.shadowColor = UIColor.black.cgColor
        detailView.layer.shadowOpacity = 0.5
        detailView.layer.shadowOffset = CGSize(width: 0, height: 2)
        detailView.layer.shadowRadius = 4
        detailView.layer.masksToBounds = false
    }
    
    func configMapViewBorder() {
        mapView.layer.borderWidth = 3.0
        mapView.layer.borderColor = UIColor.white.cgColor
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 15
    }
    
    
    func configMapViewShadow() {
        mapView.layer.shadowColor = UIColor.black.cgColor
        mapView.layer.shadowOpacity = 0.5
        mapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mapView.layer.shadowRadius = 4
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
        return CGSize(width: 150, height: 150)
    }
    
}
