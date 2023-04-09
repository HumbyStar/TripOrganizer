//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
        }
        
        homeCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell? = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
    
}
