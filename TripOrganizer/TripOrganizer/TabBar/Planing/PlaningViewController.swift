//
//  PlaningViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 22/03/23.
//

import UIKit

class PlaningViewController: UIViewController {
    
    @IBOutlet weak var lbLastUpdate: UILabel!
    @IBOutlet weak var lbFlightValue: UILabel!
    @IBOutlet weak var lbHotelValue: UILabel!
    @IBOutlet weak var lbAttractionValue: UILabel!
    @IBOutlet weak var lbRestaurantsValue: UILabel!
    @IBOutlet weak var ivUserPhoto: UIImageView!
    @IBOutlet weak var tableViewBadges: UITableView!
    
    let images: [String] = ["restaurantes-em-curitiba-barolo 1","teste","parque1"]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callDelegate()
    }
    
    func callDelegate() {
        tableViewBadges.delegate = self
        tableViewBadges.dataSource = self
    }
    
    @IBAction func tapToBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension PlaningViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaningTableViewCell", for: indexPath) as? PlaningTableViewCell else {return UITableViewCell()}
        cell.ivPerfilPlace.image = UIImage(named: images[indexPath.row])
        cell.lbAdress.text = "Av. Silva Jardim, 2487 - Água \n Verde, Curitiba - PR, 80240-020"
        cell.lbPlace.text = "Restaurante Barolo"
        cell.lbHour.text = "Horário: abre as 12:00"
        cell.lbPhone.text = "Telefone: (41) 3243-3430"
        cell.lbRating.text = "✭✭✭✭✩"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let infoRestaurantViewController = UIStoryboard(name: "InfoRestaurantVC", bundle: nil).instantiateViewController(withIdentifier: "InfoRestaurantVC") as? InfoRestaurantVC
            
            guard let infoRestaurantViewController = infoRestaurantViewController else {return}
            
            navigationController?.pushViewController(infoRestaurantViewController, animated: true)
            
            
        }
        
        if indexPath.row == 1 {
            let attractionInfoController = UIStoryboard(name: "AttractionInfoController", bundle: nil).instantiateViewController(withIdentifier: "AttractionInfoController") as? AttractionInfoController
            
            guard let attractionInfoController = attractionInfoController else {return}
            
            navigationController?.pushViewController(attractionInfoController, animated: true)
        }
        
        if indexPath.row == 2 {
            let infoHoteisViewController = UIStoryboard(name: "InfoHoteisViewController", bundle: nil).instantiateViewController(withIdentifier: "InfoHoteisViewController") as? InfoHoteisViewController
            
            guard let infoHoteisViewController = infoHoteisViewController else {return}
            
            navigationController?.pushViewController(infoHoteisViewController, animated: true)
        }
    }
}


