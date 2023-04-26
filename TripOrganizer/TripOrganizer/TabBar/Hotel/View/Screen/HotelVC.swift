//
//  HotelVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class HotelVC: UIViewController {
    
    
    public var viewModel: HotelViewModel = HotelViewModel()
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var hotelPhoneNumberLabel: UILabel!
    @IBOutlet weak var hotelOpeningHoursLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelRatingLabel: UILabel!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var hotelInfoView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configHotelMapView()
        configHotelInfoView()
    }
    
    private func configHotelMapView() {
        hotelMapView.layer.cornerRadius = 12
        hotelMapView.clipsToBounds = true
    }
    
    private func configHotelInfoView() {
        hotelInfoView.layer.cornerRadius = 12
        hotelInfoView.clipsToBounds = true
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(HoteisCollectionViewCell.nib(), forCellWithReuseIdentifier: HoteisCollectionViewCell.identifier)
    }
    
    public func configAddButton() {
        addButton.layer.cornerRadius = 15
    }
    
    @IBAction func addHotelButtonPressed(_ sender: UIButton) {
        
        
    }
    
}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRoomList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoteisCollectionViewCell.identifier, for: indexPath) as? HoteisCollectionViewCell
        cell?.setupCell(data: viewModel.getRoomListCellForItemAt(index: indexPath.row))
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
        
    }
}


