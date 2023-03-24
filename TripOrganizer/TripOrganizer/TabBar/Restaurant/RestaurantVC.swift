//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class RestaurantVC: UIViewController {

    
    @IBOutlet weak var informacaoRestauranteView: UIView!
    @IBOutlet weak var mapaRestauranteMapView: MKMapView!
    
    @IBOutlet weak var pesquisaRestauranteSearchBar: UISearchBar!
    @IBOutlet weak var fulanoLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var imagens:[String] = ["pratoDeComidaProjeto", "garrafaProjeto", "petiscoProjeto"]
    var valores:[String] = ["Valor: R$ 30,00", "Valor: R$ 50,00", "Valor: R$ 50,00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
configmenuCollectionView()
     configInformacaoRestauranteView()
        configmapaRestauranteMapView()
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
        
    }

    func configmapaRestauranteMapView(){
        mapaRestauranteMapView.layer.borderWidth = 2
        mapaRestauranteMapView.layer.borderColor = UIColor.white.cgColor
    }
    
}
extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        cell?.setupCell(image: imagens[indexPath.row], valor: valores[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 85, height: 111)
    }
    
    
    
    
}
    
    

