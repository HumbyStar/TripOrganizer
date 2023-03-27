//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Outleets
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lbWelcome: UILabel!
    @IBOutlet weak var viewInfos: UIView!
    @IBOutlet weak var lbCheckUpdate: UILabel!
    @IBOutlet weak var lbQuantityDays: UILabel!
    @IBOutlet weak var lbAirplane: UILabel!
    @IBOutlet weak var lbHotel: UILabel!
    @IBOutlet weak var lbRestaurant: UILabel!
    @IBOutlet weak var lbAttractions: UILabel!
    @IBOutlet weak var lbTotalCoast: UILabel!
    @IBOutlet weak var cvPlaces: UICollectionView!
    
    private let images: [String] = ["teste", "teste2", "teste3"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      extrasFeatures()
    }
    
    private func extrasFeatures(){
        cvPlaces.delegate = self
        cvPlaces.dataSource = self
        viewInfos.layer.borderWidth = 3
        viewInfos.layer.borderColor = UIColor.white.cgColor
        if let layout = cvPlaces.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    @IBAction func tapInPerfil(_ sender: UIButton) {
        //Chamar perfilScreen
        let perfilViewController = UIStoryboard(name: "PerfilViewController", bundle: nil).instantiateViewController(withIdentifier: "PerfilViewController") as? PerfilViewController
        
        let navigationController = UINavigationController(rootViewController: perfilViewController ?? UIViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @IBAction func goToPlannerScreen(_ sender: UIButton) {
        //Chamar plannerScreen
        
        let plainingViewController = UIStoryboard(name: "PlaningViewController", bundle: nil).instantiateViewController(withIdentifier: "PlaningViewController") as? PlaningViewController
        
        let navigationController = UINavigationController(rootViewController: plainingViewController ?? UIViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
        cell?.ivPlaces.image = UIImage(named: images[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = cvPlaces.bounds.height
        let width = cvPlaces.bounds.width
        
        return CGSize(width: 120, height: height)
    }
    
}
