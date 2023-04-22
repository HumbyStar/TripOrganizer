//
//  HotelVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

class HotelVC: UIViewController {
    
    
    
   // ["quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03","quarto01", "quarto02", "quarto03"]
    
    //var listValues: [String] = ["Diárias a partir R$130","Diárias a partir R$140","Diárias a partir R$150","Diárias a partir R$160","Diárias a partir R$170","Diárias a partir R$180","Diárias a partir R$190","Diárias a partir R$200","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170","Diárias a partir R$170"]
    
   public var viewModel: HotelViewModel = HotelViewModel()
    
    
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var horarioHotelLabel: UILabel!
    @IBOutlet weak var enderecoHotelLabel: UILabel!
    @IBOutlet weak var avaliacoesLabel: UILabel!
    @IBOutlet weak var nomeHotelLabel: UILabel!
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
        viewModel.configLayoutCollectionView(collectionView: collectionView)
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.estimatedItemSize = .zero
//        }
        collectionView.register(HoteisCollectionViewCell.nib(), forCellWithReuseIdentifier: HoteisCollectionViewCell.identifier)
    }
    
    
    
    public func configButton() {
        adicionarButton.layer.cornerRadius = 15
    }
}

extension HotelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListRoom()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoteisCollectionViewCell.identifier, for: indexPath) as? HoteisCollectionViewCell
        cell?.setupCell(data: viewModel.getListRoomCellForItemAt(index: indexPath.row))
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
//            let height = collectionView.bounds.height
//            return CGSize(width: 140, height: height - 20)
        }
}


