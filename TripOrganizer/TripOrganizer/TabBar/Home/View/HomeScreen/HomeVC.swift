//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var perfilButton: UIButton!
    @IBOutlet var homeTableview: UITableView!
    @IBOutlet var tripProgressView: UIProgressView!
    
    let cellColors = [
        UIColor.logoGreen,
        UIColor.logoOrange
    ]

//    var imageList: [String] = ["circle", "engrenagem", "estrela"]
    var viewModel: HomeViewModel = HomeViewModel()
    var tripList: [AddTrip] = []
    var emptyLabel: UILabel!
    var addTripVC: AddTripViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configTableView()
        emptyTableViewLabel()
        configProgressBar()
        changeProfileImageNotification()
        circularProfileButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
    }
    
    @objc func profileImageSelected(_ notification: Notification) {
        if let selectedImage = notification.object as? UIImage {
            self.perfilButton.setImage(selectedImage, for: .normal)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ProfileImageSelected"), object: nil)
    }
    
    private func changeProfileImageNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileImageSelected(_:)), name: Notification.Name("ProfileImageSelected"), object: nil)
    }
    
    private func configProgressBar() {
        tripProgressView.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
    }
    
    private func circularProfileButton() {
        perfilButton.clipsToBounds = true
        perfilButton.layer.cornerRadius = perfilButton.frame.height / 2
    }
    
    func emptyTableViewLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: homeTableview.bounds.size.width, height: homeTableview.bounds.size.height))
        emptyLabel.text = "Não há viagens para exibir, crie uma nova viagem clicando no botão acima."
        emptyLabel.textColor = UIColor.gray
        emptyLabel.textAlignment = .center
        homeTableview.backgroundView = emptyLabel
        homeTableview.separatorStyle = .none
        emptyLabel.numberOfLines = .zero
    }
    
    func updateTableView() {
        if tripList.count == 0 {
            homeTableview.separatorStyle = .none
            homeTableview.backgroundView?.isHidden = false
        } else {
            homeTableview.separatorStyle = .singleLine
            homeTableview.backgroundView?.isHidden = true
        }
        homeTableview.reloadData()
    }
    
    private func configTableView() {
        homeTableview.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        homeTableview.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        homeTableview.delegate = self
        homeTableview.dataSource = self
        homeTableview.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.indentifier)
        homeTableview.layer.cornerRadius = 12
        homeTableview.clipsToBounds = true
    }
    
    
    @IBAction func perfilButtonPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "PerfilViewController", bundle: nil).instantiateViewController(withIdentifier: "PerfilViewController") as? PerfilViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func addTripButtonPressed(_ sender: UIButton) {
        let vc: AddTripViewController? = UIStoryboard(name: "AddTripViewController", bundle: nil).instantiateViewController(withIdentifier: "AddTripViewController") as? AddTripViewController
        vc?.delegate(delegate: self)
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.indentifier, for: indexPath) as? HomeTableViewCell
        
        let color = cellColors[indexPath.row % cellColors.count]
        cell?.backgroundColor = color
        cell?.setupCell(trip: tripList[indexPath.row])
        cell?.placeImageView.image = UIImage(named: viewModel.tripImages[indexPath.row])
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: TripPlanViewController? = UIStoryboard(name: "TripPlanViewController", bundle: nil).instantiateViewController(withIdentifier: "TripPlanViewController") as? TripPlanViewController
        vc?.placeNameReceived = tripList[indexPath.row].tripName
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tripList.remove(at: indexPath.row)
            updateTableView()
        }
    }
    
}

extension HomeVC: AddTripviewControllerDelegate {
    func sendTrip(trip: AddTrip) {
        self.tripList.append(trip)
    }
}

