//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
