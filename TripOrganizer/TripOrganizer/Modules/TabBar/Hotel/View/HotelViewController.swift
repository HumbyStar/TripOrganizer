//
//  HotelVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

enum messageAlertHotel: String {
    case title = ""
    case addHotel = "Hotel adicionado com sucesso a sua lista de viagem!"
}

class HotelViewController: UIViewController {
    
    public var viewModel: HotelViewModel = HotelViewModel()
    
    var alert: Alert?
    
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
    @IBOutlet weak var accommodationLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        self.alert = Alert(controller: self)
        super.viewDidLoad()
        configCollectionView()
        configHotelMapView()
        configHotelInfoView()
        configSearchBar()
        configButton()
        setupUI()
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
        collectionView.register(HotelCollectionViewCell.nib(), forCellWithReuseIdentifier: HotelCollectionViewCell.identifier)
    }
    
    private func configSearchBar() {
        searchBar.placeholder = String.searchPlaceholderHotel.localized
    }
    
    private func configButton() {
        addButton.setTitle(String.addButtonTitle.localized, for: .normal)
        addButton.layer.cornerRadius = 15
    }
    
    private func setupUI(){
        hotelRatingLabel.text = String.assessmentsTitle.localized
        hotelAddressLabel.text = String.addressTitle.localized
        hotelOpeningHoursLabel.text = String.timeTitle.localized
        hotelPhoneNumberLabel.text = String.phoneTitle.localized
        accommodationLabel.text = String.accommodationTitle.localized
    }
    
    @IBAction func addHotelButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: messageAlertHotel.title.rawValue, message: messageAlertHotel.addHotel.rawValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension HotelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRoomList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell
        cell?.setupCell(data: viewModel.getRoomListCellForItemAt(index: indexPath.row))
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
        
    }
    
}


