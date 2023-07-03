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
    var homeViewModel: HomeViewModel? = HomeViewModel()
    var tripViewModel: TripPlanViewModel = TripPlanViewModel()
    public var hotelViewModel: HotelViewModel = HotelViewModel()
    
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
        hotelViewModel.fetchHotels()
        configCollectionView()
        configHotelMapView()
        configHotelInfoView()
        configSearchBar()
        configButton()
        setupUI()
        addButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(atualizarEstadoBotao), name: Notification.Name("updateList"), object: nil)
    }
    
    private func configHotelMapView() {
        hotelMapView.clipsToBounds = true
        hotelMapView.layer.cornerRadius = 12
    }
    
    private func configHotelInfoView() {
        hotelInfoView.clipsToBounds = true
        hotelInfoView.layer.cornerRadius = 12
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        hotelViewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(HotelCollectionViewCell.nib(), forCellWithReuseIdentifier: HotelCollectionViewCell.identifier)
    }
    
    private func configSearchBar() {
        searchBar.placeholder = Localized.searchPlaceholderHotel.localized
    }
    
    private func configButton() {
        addButton.setTitle(Localized.addButtonTitle.localized, for: .normal)
        addButton.layer.cornerRadius = 15
    }
    
    private func setupUI(){
        hotelRatingLabel.text = Localized.assessmentsTitle.localized
        hotelAddressLabel.text = Localized.addressTitle.localized
        hotelOpeningHoursLabel.text = Localized.timeTitle.localized
        hotelPhoneNumberLabel.text = Localized.phoneTitle.localized
        accommodationLabel.text = Localized.accommodationTitle.localized
    }
    
    @IBAction func addHotelButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: messageAlertHotel.title.rawValue, message: messageAlertHotel.addHotel.rawValue)
        
        tripViewModel.addObjectHotel(object: HotelModel(name: hotelNameLabel.text ?? "", ratings: hotelRatingLabel.text ?? "", phoneNumber: hotelPhoneNumberLabel.text ?? "", address: hotelAddressLabel.text ?? "", openingHours:  hotelOpeningHoursLabel.text ?? ""))
      
        NotificationCenter.default.post(name: NSNotification.Name("updateProgressBarHotel"), object: nil)
    }
    
    @objc func atualizarEstadoBotao() {
        if homeViewModel?.getTripList() != 0 {
                addButton.isEnabled = true
            } else {
                addButton.isEnabled = false
            }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension HotelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelViewModel.numberOfItens()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell else {
            return UICollectionViewCell()
        }
     //   let images = hotelViewModel.getHotelImages(indexPath: indexPath)
       // cell.setupCell(image: images[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return hotelViewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)

        
    }
    
}


