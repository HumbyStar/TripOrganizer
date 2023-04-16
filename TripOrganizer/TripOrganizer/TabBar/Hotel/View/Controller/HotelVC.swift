//
//  HotelVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class HotelVC: UIViewController {
    
    var listRoom: [String] = ["quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03"]
    
    //var listValues: [String] = ["Diárias a partir R$130","Diárias a partir R$140","Diárias a partir R$150","Diárias a partir R$160","Diárias a partir R$170","Diárias a partir R$180","Diárias a partir R$190","Diárias a partir R$200","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adicionarButton: UIButton!
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var cvView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configHotelMapView()
        configView()
        
    }
    
    private func configHotelMapView() {
        hotelMapView.layer.cornerRadius = 12
        hotelMapView.clipsToBounds = true
    }
    
    private func configView() {
        cvView.layer.cornerRadius = 12
        cvView.clipsToBounds = true
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        collectionView.register(HoteisCollectionViewCell.nib(), forCellWithReuseIdentifier: HoteisCollectionViewCell.identifier)
    }
    
    
    
    func configButton() {
        adicionarButton.layer.cornerRadius = 15
    }
}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRoom.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoteisCollectionViewCell.identifier, for: indexPath) as? HoteisCollectionViewCell
        cell?.imageView.image = UIImage(named: listRoom[indexPath.row])
            // cell?.setupCell(values: listValues[indexPath.row])
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: 140, height: height - 20)
    }
    
}
