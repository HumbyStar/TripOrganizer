//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

enum addRestautant: String {
    case titleEmpty = ""
    case message = "Restaurante adicionado com sucesso a sua lista de viagem!"
}

class RestaurantViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var restaurantInfoView: UIView!
    @IBOutlet weak var restaurantMapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantOpeningHoursLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumberLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    var alert: Alert?
    
    //MARK: - Variables
    private var restaurantViewModel = RestaurantViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configMenuCollectionView()
        configRestaurantInfoView()
        configRestaurantMapView()
        restaurantViewModel.loadRestaurants()
        configButton()
        configSearch()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configMenuCollectionView(){
        menuCollectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        restaurantViewModel.getCollectionViewLayout(collection: menuCollectionView)
    }
    
    private func configSearch() {
        searchBar.placeholder = Localized.searchPlaceholderRestaurant.localized
    }
    
    private func configRestaurantInfoView(){
        restaurantInfoView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    private func configButton() {
        addButton.setTitle(Localized.addButtonTitle.localized, for: .normal)
    }
    
    private func configRestaurantMapView(){
        restaurantMapView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    private func setupUI(){
        let restaurant = restaurantViewModel.cellForRow()[0]
        restaurantAddressLabel.text = Localized.addressTitle.localized + restaurant.address
        restaurantOpeningHoursLabel.text = Localized.timeTitle.localized + restaurant.openingHours
        restaurantPhoneNumberLabel.text = Localized.phoneTitle.localized + restaurant.phoneNumber
        restaurantRatingLabel.text = Localized.assessmentsTitle + String(restaurant.rating)
        restaurantNameLabel.text = restaurant.name
        menuLabel.text = Localized.menuRestaurantTitle.localized
        restaurantRatingLabel.text = Localized.assessmentsTitle.localized
    }
    
    @IBAction func addRestaurantButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: addRestautant.titleEmpty.rawValue, message: addRestautant.message.rawValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        let images = restaurantViewModel.getRestaurantImages(indexPath: indexPath)
        cell.setupCell(image: images[indexPath.row])
        cell.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = restaurantViewModel.getCollectionViewWidth(width: 140)
        let height = collectionView.bounds.height
        let newHeight = restaurantViewModel.getCollectionViewSize(height: height, extraNumber: 20)
        
        return CGSize(width: width, height: newHeight)
    }
    
}

