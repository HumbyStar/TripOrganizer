//
//  HotelVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

class HotelVC: UIViewController {
    
    var listRoom: [String] = ["quarto01"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adicionarButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoteisCollectionViewCell.identifier, for: indexPath) as? HoteisCollectionViewCell
        cell?.imageView.image = UIImage(named: "quarto01")
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        
        
        return CGSize(width: 120, height: height)
    }
    
}
