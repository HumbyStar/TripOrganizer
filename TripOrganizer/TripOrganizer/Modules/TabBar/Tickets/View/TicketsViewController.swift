//
//  SecondFlightScreenVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 11/04/23.
//

import UIKit

class TicketsViewController: UIViewController {
    
    @IBOutlet weak var calendarOnGoingLabel: UILabel!
    @IBOutlet weak var calendarOutGoingLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var flightViewModel: FlightViewModel?
    var alert: Alert?
    var selectedOnGoingDate: Date?
    var selectedReturnDate: Date?
    var originAirport: String?
    var destinationAirport: String?

    
    public let viewModel: TicketsViewModel = TicketsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configTableView()
        configProtocolsTableView()
        configureFlightData()
    }
    
    private func configureFlightData() {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           
           calendarOnGoingLabel.text = dateFormatter.string(from: selectedOnGoingDate ?? Date())
           calendarOutGoingLabel.text = dateFormatter.string(from: selectedReturnDate ?? Date())
           ticketDateLabel.text = "\(originAirport ?? "") - \(destinationAirport ?? "")"
    }
    
    private func configProtocolsTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configTableView() {
        tableView.register(FlightTableViewCell.nib(), forCellReuseIdentifier: FlightTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.showsVerticalScrollIndicator = false
    }
}

extension TicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightViewModel?.getNumberTicketList ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(data: flightViewModel?.getTicketList(index: indexPath))
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        alert?.createAlert(title: "", message: Localized.flightAddedSuccessfully.localized) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
