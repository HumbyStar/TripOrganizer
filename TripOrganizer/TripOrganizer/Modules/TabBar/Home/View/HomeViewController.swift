//
//  HomeVC.swift
//  TripOrganizer
//
//  Created by Humberto Gomes on 09/03/23.
//

import UIKit

enum emptyText: String {
    case empty = "Não há viagens para exibir, crie uma nova viagem clicando no botão acima."
}

protocol HomeViewControllerProtocol: AnyObject {
    func didUpdateData(count: Int)
}
class HomeViewController: UIViewController {
    
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet weak var changeProgressLabel: UILabel!
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
    
    
    private var progressBar: Float = 0
    var viewModel: HomeViewModel = HomeViewModel()
    weak var delegate: HomeViewControllerProtocol?
    private var fireStoreManager = FirestoreManager.shared
    
    public func setDelegate(delegate: HomeViewControllerProtocol){
        self.delegate = delegate
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configTableView()
        configLabel()
        configButton()
        emptyTableViewLabel()
        configProgressBar()
        changeProfileImageNotification()
        circularProfileButton()
        configImagesViews()
        notificationCenterProgressBar()
        getProfileImage()
    }
    
    private func getProfileImage() {
        fireStoreManager.getObjectData(collection: "user", forObjectType: User.self) { result in
            switch result {
            case .success(let sucess):
                let user = sucess
                if let imageData = user.profileImage {
                    self.perfilButton.setImage(UIImage(data: imageData), for: .normal)
                } else {
                    let defaultImage = UIImage(systemName: "person")
                    self.perfilButton.setImage(defaultImage, for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func notificationCenterProgressBar(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBarAndImageViewRestaurant), name: Notification.Name("updateProgressBarRestaurant"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBarAndImageViewHotel), name: Notification.Name("updateProgressBarHotel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBarAndImageViewAttracion), name: Notification.Name("updateProgressBarAttraction"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBarAndImageViewTickets), name: Notification.Name("updateProgressBarTickets"), object: nil)
    }
    
    func configImagesViews() {
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
            case UIImage(systemName: Localized.square):
                ticketImageView.image = UIImage(systemName: Localized.squareCheck)
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            case UIImage(systemName: Localized.squareCheck):
                ticketImageView.image = UIImage(systemName: Localized.square)
                progressBar -= 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            default:
                break
            }
        case tappedHotelView:
            switch hotelImageView.image {
            case UIImage(systemName: Localized.square.localized):
                hotelImageView.image = UIImage(systemName: Localized.squareCheck)
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            case UIImage(systemName: Localized.squareCheck):
                hotelImageView.image = UIImage(systemName: Localized.square)
                progressBar -= 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            default:
                break
            }
            
        case tappedRestaurantView:
            switch restaurantImageView.image {
            case UIImage(systemName: Localized.square):
                restaurantImageView.image = UIImage(systemName: Localized.squareCheck)
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            case UIImage(systemName: Localized.squareCheck):
                restaurantImageView.image = UIImage(systemName: Localized.square)
                progressBar -= 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            default:
                break
            }
            
        case tappedAttractionView:
            switch attractionImageView.image {
            case UIImage(systemName: Localized.square):
                attractionImageView.image = UIImage(systemName: Localized.squareCheck)
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            case UIImage(systemName: Localized.squareCheck):
                attractionImageView.image = UIImage(systemName: Localized.square)
                progressBar -= 0.25
                tripProgressView.setProgress(progressBar, animated: true)
            default:
                break
            }
            
        default:
            break
        }
    }
    
    @objc  func updateProgressBarAndImageViewRestaurant() {
        progressBar += 0.25
        tripProgressView.setProgress(progressBar, animated: true)
        restaurantImageView.image = UIImage(systemName: Localized.squareCheck)
    }
    
    @objc  func updateProgressBarAndImageViewHotel() {
        progressBar += 0.25
        tripProgressView.setProgress(progressBar, animated: true)
        hotelImageView.image = UIImage(systemName: Localized.squareCheck)
    }
    
    @objc  func updateProgressBarAndImageViewAttracion() {
        progressBar += 0.25
        tripProgressView.setProgress(progressBar, animated: true)
        attractionImageView.image = UIImage(systemName: Localized.squareCheck)
    }
    
    @objc  func updateProgressBarAndImageViewTickets() {
        progressBar += 0.25
        tripProgressView.setProgress(progressBar, animated: true)
        ticketImageView.image = UIImage(systemName: Localized.squareCheck)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
    }
    
    @objc func profileImageSelected(_ notification: Notification) {
        viewModel.getProfileImageSelected(notification: notification, perfilButton: perfilButton)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(ProfileImageSelected.profileImage.rawValue), object: nil)
    }
    
    private func changeProfileImageNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(profileImageSelected(_:)), name: Notification.Name(ProfileImageSelected.profileImage.rawValue), object: nil)
    }
    
    private func configProgressBar() {
        tripProgressView.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
    }
    
    private func circularProfileButton() {
        perfilButton.clipsToBounds = true
        perfilButton.layer.cornerRadius = perfilButton.frame.height / 2
    }
    
    private func configLabel() {
        appNameLabel.text = Localized.tripTitle.localized
        greetingLabel.text = Localized.welcomeLabelTitle.localized
        changeProgressLabel.text = Localized.changeProgressTitle.localized
    }
    
    private func configButton() {
        addTripButton.setTitle(Localized.addTripButtonTitle.localized, for: .normal)
    }
    
    private func emptyTableViewLabel() {
        var emptyLabel : UILabel
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: homeTableView.bounds.size.width, height: homeTableView.bounds.size.height))
        emptyLabel.text = emptyText.empty.rawValue
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
        let vc = UIStoryboard(name: Localized.profileViewController, bundle: nil).instantiateViewController(withIdentifier: Localized.profileViewController) as? ProfileViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func addTripButtonPressed(_ sender: UIButton) {
        let vc: AddTripViewController? = UIStoryboard(name: Localized.addTripViewController, bundle: nil).instantiateViewController(withIdentifier: Localized.addTripViewController) as? AddTripViewController
        vc?.delegate(delegate: self)
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let cellColors = [
            UIColor.logoGreen,
            UIColor.logoOrange
        ]
        let color: UIColor = cellColors[indexPath.row % cellColors.count]
        cell.backgroundColor = color
        cell.setupCell(trip: viewModel.getTripList(index: indexPath.row))
        cell.placeImageView.image = UIImage(named: viewModel.getListTripImages(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tripNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: TripPlanViewController? = UIStoryboard(name: Localized.tripPlanViewController, bundle: nil).instantiateViewController(withIdentifier: Localized.tripPlanViewController) as? TripPlanViewController
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

