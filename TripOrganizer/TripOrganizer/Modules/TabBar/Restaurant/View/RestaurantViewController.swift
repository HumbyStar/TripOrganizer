//
//  RestaurantVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit
import GooglePlaces

enum addRestautant: String {
    case titleEmpty = ""
    case message = "Restaurante adicionado com sucesso a sua lista de viagem!"
}

class RestaurantViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var restaurantInfoView: UIView!
    @IBOutlet weak var restaurantMapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantOpeningHoursLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumberLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var viewInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var infoToSearchLabel: UILabel!
    
    private var viewModel: RestaurantViewModel = RestaurantViewModel()
    var alert: Alert?
    var homeViewModel: HomeViewModel? = HomeViewModel()
    private var fireStoreManager = FirestoreManager.shared
    
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        collectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        return collectionView
    }()
    
    //MARK: - Variables
    private var restaurantViewModel = RestaurantViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configRestaurantMapView()
        configRestaurantInfoView()
        configButton()
        configSearch()
        
        viewModel.regionUpdaterHandler = {[weak self] (region) in
            guard let self = self else {return}
            self.restaurantMapView.setRegion(region, animated: true)
        }
        
        viewModel.annotationUpdateHandler = {[weak self] (annotations) in
            print(annotations)
            self?.restaurantMapView.removeAnnotations(self?.restaurantMapView.annotations ?? [])
            self?.restaurantMapView.addAnnotations(annotations)
            self?.restaurantMapView.showAnnotations(annotations, animated: true)
        }
        
        viewModel.completion = { [weak self] places in
            guard let self = self else {return}
            
            if self.viewInfoHeight.constant == 153 {
                self.displayDetailsScreen(local: places)
                self.showView(check: true)
                self.updateCollectionView()
            } else {
                self.changePlaceAnimated(infoPlace: places)
            }
        }
        
        viewModel.updateCollectionView = {
            self.viewModel.isLoading = false
            self.menuCollectionView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: Notification.Name("updateList"), object: nil)
        updateButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func updateCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        restaurantInfoView.addSubview(menuCollectionView)
        
        menuCollectionView.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: 10).isActive = true
        menuCollectionView.leadingAnchor.constraint(equalTo: restaurantInfoView.leadingAnchor).isActive = true
        menuCollectionView.trailingAnchor.constraint(equalTo: restaurantInfoView.trailingAnchor).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: restaurantInfoView.bottomAnchor).isActive = true
    }
    
    private func showView(check: Bool) {
        if check {
            self.viewInfoHeight.constant = 315
        } else {
            self.viewInfoHeight.constant = 153
        }
        
        UIView.animate(withDuration: 0.8) {
            self.restaurantInfoView.backgroundColor = .white
            self.restaurantInfoView.alpha = 1
            self.infoToSearchLabel.alpha = 0
            self.restaurantInfoView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    private func changePlaceAnimated(infoPlace: PlaceData) {
        UIView.animate(withDuration: 0.6) {
            self.restaurantNameLabel.alpha = 0
            self.restaurantRatingLabel.alpha = 0
            self.restaurantAddressLabel.alpha = 0
            self.restaurantPhoneNumberLabel.alpha = 0
            self.restaurantOpeningHoursLabel.alpha = 0
            self.menuLabel.alpha = 0
            self.menuCollectionView.alpha = 0
            self.addButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.4) {
                self.displayDetailsScreen(local: infoPlace)
                self.restaurantNameLabel.alpha = 1
                self.restaurantRatingLabel.alpha = 1
                self.restaurantAddressLabel.alpha = 1
                self.restaurantPhoneNumberLabel.alpha = 1
                self.restaurantOpeningHoursLabel.alpha = 1
                self.menuLabel.alpha = 1
                self.menuCollectionView.alpha = 1
                self.addButton.alpha = 1
            }
        }
    }
    
    private func displayDetailsScreen(local: PlaceData) {
        switch local {
        case .restaurantModel(let restaurant):
            restaurantPhoneNumberLabel.text = restaurant[0].phoneNumber
            restaurantRatingLabel.text = restaurant[0].ratings
            restaurantNameLabel.text = restaurant[0].name
            restaurantOpeningHoursLabel.text = restaurant[0].openingHours
            restaurantAddressLabel.text = restaurant[0].address
            
        case .gmsPlace(let gmsRestaurant):
            if gmsRestaurant.phoneNumber != nil {
                restaurantPhoneNumberLabel.text = "\(Localized.contactLabelTitle) \(gmsRestaurant.phoneNumber ?? "")"
            } else {
                restaurantPhoneNumberLabel.text = Localized.invalidContact
            }
            
            restaurantRatingLabel.text = "\(Localized.ratingLabelTitle) \(gmsRestaurant.rating)"
            restaurantOpeningHoursLabel.text = viewModel.checkLocalHour(dataHour: gmsRestaurant.isOpen())
            restaurantNameLabel.text = gmsRestaurant.name
            restaurantAddressLabel.text = gmsRestaurant.formattedAddress
            
            guard let photos = gmsRestaurant.photos else {
                viewModel.loadLocalPhotos(photos: nil)
                return
            }
            
            viewModel.loadLocalPhotos(photos: photos)
            self.menuCollectionView.reloadData()
            
        default:
            break
        }
        
    }
    
    private func configSearch() {
        searchBar.placeholder = Localized.searchPlaceholderRestaurant.localized
    }
    
    private func configRestaurantInfoView(){
        restaurantInfoView.layer.cornerRadius = 12
    }
    
    private func configButton() {
        addButton.setTitle(Localized.addButtonTitle.localized, for: .normal)
    }
    
    private func configRestaurantMapView(){
        restaurantMapView.layer.cornerRadius = 12
    }
    
    @IBAction func addRestaurantButtonPressed(_ sender: UIButton) {
        guard let image = viewModel.localPhotos.first,
              let imageData = image.jpegData(compressionQuality: .leastNonzeroMagnitude) else {
            
            return
        }
        
        alert?.createAlert(title: addRestautant.titleEmpty.rawValue, message: addRestautant.message.rawValue)
        
        fireStoreManager.addPlace(place: Places(images: imageData, name: restaurantNameLabel.text ?? "", ratings: restaurantRatingLabel.text ?? "", phoneNumber: restaurantPhoneNumberLabel.text ?? "", address: restaurantAddressLabel.text ?? "", openingHours: restaurantOpeningHoursLabel.text ?? "")) { result in
            
            switch result {
            case .success:
                print("Lugar adicionado com sucesso!")
            case .failure(let error):
                print("Erro ao adicionar lugar: \(error.localizedDescription)")
            }
        
        NotificationCenter.default.post(name: NSNotification.Name("updateProgressBarRestaurant"), object: nil)
    }
}

@objc func updateButtonState() {
    if homeViewModel?.getTripList() != 0 {
        addButton.isEnabled = true
    } else {
        addButton.isEnabled = false
    }
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
}

}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isUsingMockData {
            return viewModel.numberOfItens()
        } else {
            
            return viewModel.isLoading ? viewModel.skeletonCount :
            viewModel.localPhotos.isEmpty ? viewModel.numberOfItens() :
            viewModel.localPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        
        if viewModel.isUsingMockData {
            let restaurantImage = "abobrinha"//viewModel.getRestaurantImages()[indexPath.row]
            if let image = UIImage(named: restaurantImage) {
                cell.hideSkeleton()
                cell.setupCell(image: image)
            }
        } else {
            if viewModel.isLoading {
                cell.showSkeleton()
            } else {
                cell.hideSkeleton()
                //                viewModel.localPhotos.isEmpty ? cell.setupCell(image: UIImage(named: viewModel.getRestaurantImages()[indexPath.row]) ?? UIImage()) :
                cell.setupCell(image: viewModel.localPhotos[indexPath.row])
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return restaurantViewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
    }
    
}

extension RestaurantViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.findRestaurant(typed: searchBar.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.infoToSearchLabel.alpha = 0
            } completion: {_ in
                UIView.animate(withDuration: 0.5) {
                    if self.restaurantInfoView.alpha == 0 {
                        self.infoToSearchLabel.text = Localized.touchDetailsLabelTitle
                        self.infoToSearchLabel.alpha = 1
                    }
                }
            }
            self.restaurantMapView.removeAnnotations(self.restaurantMapView.annotations)
            self.viewModel.buildMKPoints(region: self.restaurantMapView.region)
        }
    }
}

extension RestaurantViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "Annotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .orange
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            let placeName = annotation.title ?? ""
            let regionTyped = searchBar.text
            
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            let stringFinal = "\(Localized.titleRestaurantView),\(placeName),\(regionTyped ?? "")"
            
            viewModel.isLoading = true
            viewModel.searchEstabilishment(value: stringFinal, filter: filter)
        }
    }
}
