//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class RestaurantVC: UIViewController {
    
    
    @IBOutlet weak var adicionarButton: UIButton!
    @IBOutlet weak var informacaoRestauranteView: UIView!
    @IBOutlet weak var mapaRestauranteMapView: MKMapView!
    
    @IBOutlet weak var pesquisaRestauranteSearchBar: UISearchBar!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var imagens:[String] = ["pratoDeComidaProjeto", "garrafaProjeto", "petiscoProjeto", "almocoProjeto"]
   // var valores:[String] = ["Valor: R$ 30,00", "Valor: R$ 50,00", "Valor: R$ 50,00", "Valor: R$ 35,00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configmenuCollectionView()
        configInformacaoRestauranteView()
        configmapaRestauranteMapView()
        configpesquisaRestauranteSearchBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func configmenuCollectionView(){
        menuCollectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        if let layout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        
    }
    func configInformacaoRestauranteView(){
        informacaoRestauranteView.layer.cornerRadius = 12
    }
    
    func configmapaRestauranteMapView(){
        mapaRestauranteMapView.layer.cornerRadius = 12
        
    }
    
    func configpesquisaRestauranteSearchBar(){
        pesquisaRestauranteSearchBar.placeholder = "Procure um restaurante para visitar"
            
        }
    }

extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        cell?.setupCell(image: imagens[indexPath.row])//, valor: valores[indexPath.row])
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: 140, height: height - 20)
    }
    
}

