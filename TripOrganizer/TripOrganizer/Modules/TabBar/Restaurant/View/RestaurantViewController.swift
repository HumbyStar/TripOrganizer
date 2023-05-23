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
    @IBOutlet weak var mapaRestauranteMapView: MKMapView!
    @IBOutlet weak var pesquisaRestauranteSearchBar: UISearchBar!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantOpeningHoursLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumberLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cardapioLabel: UILabel!
    
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
        configTitles()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func configMenuCollectionView(){
        menuCollectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        restaurantViewModel.getCollectionViewLayout(collection: menuCollectionView)
    }
    
    
    func configRestaurantInfoView(){
        restaurantInfoView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    private func configButton() {
        addButton.setTitle(String.addButtonTitle.localized, for: .normal)
    }
    
    private func configTitles() {
        cardapioLabel.text = String.MenuRestaurantTitle.localized
        pesquisaRestauranteSearchBar.placeholder = String.searchPlaceholderRestaurant.localized
    }
    
    private func configRestaurantMapView(){
        mapaRestauranteMapView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    private func setupUI(){
        let restaurant = restaurantViewModel.cellForRow()[0]
        restaurantAddressLabel.text = "Endereço: \(restaurant.address)"
        restaurantOpeningHoursLabel.text = "Horário: \(restaurant.openingHours)"
        restaurantPhoneNumberLabel.text = "Telefone: \(restaurant.phoneNumber)"
        restaurantRatingLabel.text = "Avaliações - \(restaurant.rating)"
        restaurantNameLabel.text = restaurant.name
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        let images = restaurantViewModel.getRestaurantImages(indexPath: indexPath)
        cell?.setupCell(image: images[indexPath.row])
        cell?.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 10)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = restaurantViewModel.getCollectionViewWidth(width: 140)
        let height = collectionView.bounds.height
        let newHeight = restaurantViewModel.getCollectionViewSize(height: height, extraNumber: 20)
        
        return CGSize(width: width, height: newHeight)
    }
    
}

