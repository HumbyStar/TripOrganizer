//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.showsVerticalScrollIndicator = false
        self.configTableView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            cell?.setupCell(placeType: "Lazer")
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            let cell: HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            cell?.setupCell(placeType: "Restaurantes")
            return cell ?? UITableViewCell()
        } else {
            let cell: HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            cell?.setupCell(placeType: "Hotel")
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
