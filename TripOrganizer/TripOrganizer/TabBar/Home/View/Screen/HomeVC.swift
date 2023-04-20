//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var perfilButton: UIButton!
    @IBOutlet var homeCollectionView: UICollectionView!
    @IBOutlet var tripProgressView: UIProgressView!

//    var imageList: [String] = ["circle", "engrenagem", "estrela"]
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configCollectionview()
        configProgressBar()
    }
    
    private func configProgressBar() {
        tripProgressView.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
    }
    
    private func configCollectionview() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        homeCollectionView.register(AttractionCollectionViewCell.nib(), forCellWithReuseIdentifier: AttractionCollectionViewCell.identifier)
        homeCollectionView.register(RestaurantCollectionViewCell.nib(), forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
        homeCollectionView.register(HotelCollectionViewCell.nib(), forCellWithReuseIdentifier: HotelCollectionViewCell.identifier)
        homeCollectionView.showsVerticalScrollIndicator = false
    }
    
    
    @IBAction func perfilButtonPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "PerfilViewController", bundle: nil).instantiateViewController(withIdentifier: "PerfilViewController") as? PerfilViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.homeNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell: AttractionCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: AttractionCollectionViewCell.identifier, for: indexPath) as? AttractionCollectionViewCell
            cell?.setupCell(placeType: "Lazer")
            return cell ?? UICollectionViewCell()
        } else if indexPath.row == 1 {
            let cell: RestaurantCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath) as? RestaurantCollectionViewCell
            cell?.setupCell(placeType: "Restaurante")
            return cell ?? UICollectionViewCell()
        } else {
            let cell: HotelCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell
            cell?.setupCell(placeType: "Hotel")
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = homeCollectionView.bounds.width
        let height = homeCollectionView.bounds.height * 0.6
        return CGSize(width: width, height: height)

    }
    
}
