//
//  LoungeVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class AttractionViewController: UIViewController {
    
    
    public let viewModel: AttractionViewModel = AttractionViewModel()
    
    var alert: Alert?
    
    @IBOutlet weak var attractionRatingLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var attractionMapView: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var attractionInfoView: UIView!
    @IBOutlet var addAttractionButton: UIButton!
    @IBOutlet var attractionNameLabel: UILabel!
    @IBOutlet var attractionAdressLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    @IBOutlet var attractionPhoneNumberLabel: UILabel!
    @IBOutlet var entranceFeeLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configCollectionView()
        roundedBorder()
    }
    
    private func roundedBorder() {
        attractionInfoView.layer.cornerRadius = 12
        attractionMapView.layer.cornerRadius = 12
    }
    
    
    private func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        viewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(AttractionCell.nib(), forCellWithReuseIdentifier: AttractionCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    @IBAction func tappedAddAttractionButton(_ sender: UIButton) {
        alert?.createAlert(title: "", message: "Lazer adicionado com sucesso a sua lista de viagem!")
    }
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
