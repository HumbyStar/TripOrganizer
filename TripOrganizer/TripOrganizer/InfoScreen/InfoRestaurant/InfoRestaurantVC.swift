//
//  InfoRestaurantVC.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 25/03/23.
//

import UIKit

class InfoRestaurantVC: UIViewController {
    
    @IBOutlet weak var cardapioCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func configCardapioCollectionView(){
        
        cardapioCollectionView.delegate = self
        cardapioCollectionView.dataSource = self
        cardapioCollectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        
        
    }
    

}


