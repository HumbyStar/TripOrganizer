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
    
    var restaurant: [String] = ["restaurante1", "restaurante2"]
    
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
        
        homeCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        homeCollectionView.showsVerticalScrollIndicator = false
    }
    
    
    @IBAction func perfilButtonPressed(_ sender: UIButton) {
        
    }
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell: HomeCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.setupCell(placeType: "Lazer")
            return cell ?? UICollectionViewCell()
        } else if indexPath.row == 1 {
            let cell: HomeCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.setupCell(placeType: "Restaurantes")
            return cell ?? UICollectionViewCell()
        } else {
            let cell: HomeCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.setupCell(placeType: "Hotel")
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = homeCollectionView.bounds.width
        let height = homeCollectionView.bounds.height * 0.8
        return CGSize(width: width, height: height)

    }
    
}
