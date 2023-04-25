//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class RestaurantVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var adicionarButton: UIButton!
    @IBOutlet weak var informacaoRestauranteView: UIView!
    @IBOutlet weak var mapaRestauranteMapView: MKMapView!
    @IBOutlet weak var pesquisaRestauranteSearchBar: UISearchBar!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var lbAdress: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbCellphone: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbPlace: UILabel!

    
    //MARK: - Variables
    private var restaurantViewModel = RestaurantViewModel()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configmenuCollectionView()
        configInformacaoRestauranteView()
        configmapaRestauranteMapView()
        restaurantViewModel.loadRestaurants()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func configmenuCollectionView(){
        menuCollectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        restaurantViewModel.getCollectionViewLayout(collection: menuCollectionView)
    }
    func configInformacaoRestauranteView(){
        informacaoRestauranteView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    func configmapaRestauranteMapView(){
        mapaRestauranteMapView.layer.cornerRadius = restaurantViewModel.getCornerRadius(value: 12)
    }
    
    func setupUI(){
        let restaurant = restaurantViewModel.cellForRow()[0]
        lbAdress.text = "Endereço: \(restaurant.restaurantAdress)"
        lbHour.text = "Horário: \(restaurant.restaurantHour)"
        lbCellphone.text = "Telefone: \(restaurant.restarauntCellphone)"
        lbRating.text = "Avaliações - \(restaurant.restaurantRating)"
        lbPlace.text = restaurant.restaurantName
    }
    
    @IBAction func addedRestaurant(_ sender: UIButton) {
        
    }
}

extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        let images = restaurantViewModel.getRestarauntImages(indexPath: indexPath)
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

