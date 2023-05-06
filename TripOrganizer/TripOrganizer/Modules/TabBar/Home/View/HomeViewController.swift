//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet weak var tappedTicketView: UIView!
    @IBOutlet weak var tappedHotelView: UIView!
    @IBOutlet weak var tappedRestaurantView: UIView!
    @IBOutlet weak var tappedAttractionView: UIView!
    @IBOutlet weak var ticketImageView: UIImageView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var attractionImageView: UIImageView!
    @IBOutlet var perfilButton: UIButton!
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet var tripProgressView: UIProgressView!
    @IBOutlet var addTripButton: UIButton!
    
    let cellColors = [
        UIColor.logoGreen,
        UIColor.logoOrange
    ]
    
    var progressBar: Float = 0
    var viewModel: HomeViewModel = HomeViewModel()
    var emptyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configTableView()
        emptyTableViewLabel()
        configProgressBar()
        changeProfileImageNotification()
        circularProfileButton()
        configImagesViews()
    }
    
    private func configImagesViews() {
        let imageViews = [tappedTicketView, tappedHotelView, tappedRestaurantView, tappedAttractionView]
        
        for imageView in imageViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView?.addGestureRecognizer(tapGesture)
            imageView?.isUserInteractionEnabled = true
        }
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
       
        guard let imageView = sender.view else { return }
        
         switch imageView {
         case tappedTicketView:
             switch ticketImageView.image {
             case UIImage(systemName: "square.fill"):
                 ticketImageView.image = UIImage(systemName: "checkmark.square.fill")
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: "checkmark.square.fill"):
                 ticketImageView.image = UIImage(systemName: "square.fill")
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
         case tappedHotelView:
             switch hotelImageView.image {
             case UIImage(systemName: "square.fill"):
                 hotelImageView.image = UIImage(systemName: "checkmark.square.fill")
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: "checkmark.square.fill"):
                 hotelImageView.image = UIImage(systemName: "square.fill")
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         case tappedRestaurantView:
             switch restaurantImageView.image {
             case UIImage(systemName: "square.fill"):
                 restaurantImageView.image = UIImage(systemName: "checkmark.square.fill")
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: "checkmark.square.fill"):
                 restaurantImageView.image = UIImage(systemName: "square.fill")
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         case tappedAttractionView:
             switch attractionImageView.image {
             case UIImage(systemName: "square.fill"):
                 attractionImageView.image = UIImage(systemName: "checkmark.square.fill")
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: "checkmark.square.fill"):
                 attractionImageView.image = UIImage(systemName: "square.fill")
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         default:
             break
         }
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
    
    private func emptyTableViewLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: homeTableView.bounds.size.width, height: homeTableView.bounds.size.height))
        emptyLabel.text = "Não há viagens para exibir, crie uma nova viagem clicando no botão acima."
        emptyLabel.textColor = UIColor.gray
        emptyLabel.textAlignment = .center
        homeTableView.backgroundView = emptyLabel
        homeTableView.separatorStyle = .none
        emptyLabel.numberOfLines = .zero
    }
    
    private func updateTableView() {
        if viewModel.tripNumberOfRows == 0 {
            homeTableView.separatorStyle = .none
            homeTableView.backgroundView?.isHidden = false
        } else {
            homeTableView.separatorStyle = .singleLine
            homeTableView.backgroundView?.isHidden = true
        }
        homeTableView.reloadData()
    }
    
    private func configTableView() {
        homeTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        homeTableView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        homeTableView.layer.cornerRadius = 12
        homeTableView.clipsToBounds = true
    }
    
    
    @IBAction func perfilButtonPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func addTripButtonPressed(_ sender: UIButton) {
        let vc: AddTripViewController? = UIStoryboard(name: "AddTripViewController", bundle: nil).instantiateViewController(withIdentifier: "AddTripViewController") as? AddTripViewController
        vc?.delegate(delegate: self)
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        
        let color = cellColors[indexPath.row % cellColors.count]
        cell?.backgroundColor = color
        cell?.setupCell(trip: viewModel.getTripList(index: indexPath.row))
        cell?.placeImageView.image = UIImage(named: viewModel.getListTripImages(index: indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: TripPlanViewController? = UIStoryboard(name: "TripPlanViewController", bundle: nil).instantiateViewController(withIdentifier: "TripPlanViewController") as? TripPlanViewController
        vc?.placeNameReceived = viewModel.getTripList(index: indexPath.row).tripName
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTrip(index: indexPath.row)
            updateTableView()
        }
    }

}

extension HomeViewController: AddTripviewControllerDelegate {
    func sendTrip(trip: AddTripModel) {
        viewModel.appendTripToList(trip: trip)
    }
}

