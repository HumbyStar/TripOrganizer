//
//  SecondFlightScreenVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class SecondFlightScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public let viewModel: SecondFlightViewModel = SecondFlightViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FlightTableViewCell.nib(), forCellReuseIdentifier: FlightTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.showsVerticalScrollIndicator = false
    }
    
}

extension SecondFlightScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.clipsToBounds = true
        cell?.layer.cornerRadius = 12
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getDidSelectRowAt(tableView: tableView, indexPath: indexPath)
    }
}
