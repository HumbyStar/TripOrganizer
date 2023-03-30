//
//  InfoRestaurantVC.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 25/03/23.
//

import UIKit

class InfoRestaurantVC: UIViewController {
    
    
    @IBOutlet weak var cardapioCollectionView: UICollectionView!
    var imagens:[String] = ["garrafaProjeto", "petiscoProjeto", "almocoProjeto"]
    var valores:[String] = ["R$ 30,00", "R$ 50,00", "R$ 50,00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCardapioCollectionView()
    }
    
    func configCardapioCollectionView(){
        
        cardapioCollectionView.delegate = self
        cardapioCollectionView.dataSource = self
        cardapioCollectionView.register(InfoRestaurantVCCell.nib(), forCellWithReuseIdentifier: InfoRestaurantVCCell.identifier)
        if let layout = cardapioCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension InfoRestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoRestaurantVCCell.identifier, for: indexPath) as? InfoRestaurantVCCell
        cell?.setupCell(image: imagens[indexPath.row], valor: valores[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 145)
        
    }
}

