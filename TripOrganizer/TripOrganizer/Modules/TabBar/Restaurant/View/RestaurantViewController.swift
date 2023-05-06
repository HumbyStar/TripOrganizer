//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

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
    
    
    func configRestaurantMapView(){
        mapaRestauranteMapView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    func setupUI(){
        let restaurant = restaurantViewModel.cellForRow()[0]
        restaurantAddressLabel.text = "Endereço: \(restaurant.restaurantAdress)"
        restaurantOpeningHoursLabel.text = "Horário: \(restaurant.restaurantOpeningHours)"
        restaurantPhoneNumberLabel.text = "Telefone: \(restaurant.restarauntPhoneNumber)"
        restaurantRatingLabel.text = "Avaliações - \(restaurant.restaurantRating)"
        restaurantNameLabel.text = restaurant.restaurantName
    }
    
    @IBAction func addRestaurantButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: "", message: "Restaurante adicionado com sucesso a sua lista de viagem!")
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

