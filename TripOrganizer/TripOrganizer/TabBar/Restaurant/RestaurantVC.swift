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
    @IBOutlet weak var fulanoLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var imagens:[String] = ["pratoDeComidaProjeto", "garrafaProjeto", "petiscoProjeto", "almocoProjeto"]
    var valores:[String] = ["Valor: R$ 30,00", "Valor: R$ 50,00", "Valor: R$ 50,00", "Valor: R$ 35,00"]
    
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
        informacaoRestauranteView.layer.borderWidth = 2
        informacaoRestauranteView.layer.borderColor = UIColor.white.cgColor
        informacaoRestauranteView.layer.cornerRadius = 8.0
        informacaoRestauranteView.layer.masksToBounds = true
    }
    
    func configmapaRestauranteMapView(){
        mapaRestauranteMapView.layer.borderWidth = 2
        mapaRestauranteMapView.layer.borderColor = UIColor.white.cgColor
        mapaRestauranteMapView.layer.cornerRadius = 8.0
        mapaRestauranteMapView.layer.masksToBounds = true
        
    }
    
    func configpesquisaRestauranteSearchBar(){
        pesquisaRestauranteSearchBar.placeholder = "Procure um ponto turístico para visitar"
        if let textField = pesquisaRestauranteSearchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 13)
        }
    }
}
    extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        cell?.setupCell(image: imagens[indexPath.row], valor: valores[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 89, height: 143)
    }
    
}

