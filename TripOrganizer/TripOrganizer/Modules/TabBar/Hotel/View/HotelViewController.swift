//
//  HotelVC.swift
//  TripOrganizer


import UIKit
import MapKit
import GooglePlaces

class HotelViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var hotelPhoneNumberLabel: UILabel!
    @IBOutlet weak var hotelOpeningHoursLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelRatingLabel: UILabel!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var hotelInfoView: UIView!
    @IBOutlet weak var accommodationLabel: UILabel!
    @IBOutlet weak var viewInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var infoToSearchLabel: UILabel!
    
    public var viewModel: HotelViewModel = HotelViewModel()
    
    var alert: Alert?
    var localPhotos: [UIImage] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        collectionView.register(HotelCollectionViewCell.nib(), forCellWithReuseIdentifier: HotelCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        hotelMapView.delegate = self
        configHotelMapView()
        configHotelInfoView()
        configSearchBar()
        configButton()
        
        viewModel.regionUpdaterHandler = {[weak self] (region) in
            guard let self = self else {return}
            self.hotelMapView.setRegion(region, animated: true)
        }
        
        viewModel.annotationUpdateHandler = {[weak self] (annotations) in
            print(annotations)
            self?.hotelMapView.removeAnnotations(self?.hotelMapView.annotations ?? [])
            self?.hotelMapView.addAnnotations(annotations)
            self?.hotelMapView.showAnnotations(annotations, animated: true)
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
            self.collectionView.reloadData()
        }
        
    }
    
    private func changePlaceAnimated(infoPlace: PlaceData) {
        UIView.animate(withDuration: 0.6) {
            self.hotelNameLabel.alpha = 0
            self.hotelRatingLabel.alpha = 0
            self.hotelAddressLabel.alpha = 0
            self.hotelPhoneNumberLabel.alpha = 0
            self.hotelOpeningHoursLabel.alpha = 0
            self.accommodationLabel.alpha = 0
            self.collectionView.alpha = 0
            self.addButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.4) {
                self.displayDetailsScreen(local: infoPlace)
                self.hotelNameLabel.alpha = 1
                self.hotelRatingLabel.alpha = 1
                self.hotelAddressLabel.alpha = 1
                self.hotelPhoneNumberLabel.alpha = 1
                self.hotelOpeningHoursLabel.alpha = 1
                self.accommodationLabel.alpha = 1
                self.collectionView.alpha = 1
                self.addButton.alpha = 1
            }
        }
    }
    
    private func updateCollectionView() { 
        collectionView.delegate = self
        collectionView.dataSource = self
        hotelInfoView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: accommodationLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: hotelInfoView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: hotelInfoView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: hotelInfoView.bottomAnchor).isActive = true
    }
    
    private func showView(check: Bool) {
        if check {
            self.viewInfoHeight.constant = 315
        } else {
            self.viewInfoHeight.constant = 153
        }
        
        UIView.animate(withDuration: 0.8) {
            self.hotelInfoView.backgroundColor = .white
            self.hotelInfoView.alpha = 1
            self.infoToSearchLabel.alpha = 0
            self.hotelInfoView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    private func displayDetailsScreen(local: PlaceData) {
        switch local {
        case .hotelModel(let hotel):
            hotelPhoneNumberLabel.text = hotel[0].phoneNumber
            hotelRatingLabel.text = hotel[0].rating
            hotelNameLabel.text = hotel[0].name
            hotelOpeningHoursLabel.text = hotel[0].openingHours
            hotelAddressLabel.text = hotel[0].address
            
        case .gmsPlace(let gmsHotel):
            if gmsHotel.phoneNumber != nil {
                hotelPhoneNumberLabel.text = "\(Localized.contactLabelTitle) \(gmsHotel.phoneNumber ?? "")"
            } else {
                hotelPhoneNumberLabel.text = Localized.invalidContact
            }
            
            hotelRatingLabel.text = "\(Localized.ratingLabelTitle) \(gmsHotel.rating)"
            hotelOpeningHoursLabel.text = viewModel.checkLocalHour(dataHour: gmsHotel.isOpen())
            hotelNameLabel.text = gmsHotel.name
            hotelAddressLabel.text = gmsHotel.formattedAddress
            
            guard let photos = gmsHotel.photos else {return}
            
            viewModel.loadLocalPhotos(photos: photos)
            self.collectionView.reloadData()
            
        default:
            break
        }

    }
    
    private func configHotelMapView() {
        hotelMapView.clipsToBounds = true
        hotelMapView.layer.cornerRadius = 12
    }
    
    private func configHotelInfoView() {
        hotelInfoView.clipsToBounds = true
        hotelInfoView.layer.cornerRadius = 12
    }
    
    private func configSearchBar() {
        searchBar.placeholder = Localized.searchPlaceholderHotel.localized
    }
    
    private func configButton() {
        addButton.setTitle(Localized.addButtonTitle.localized, for: .normal)
        addButton.layer.cornerRadius = 15
    }

    @IBAction func addHotelButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: messageAlertHotel.title.rawValue, message: messageAlertHotel.addHotel.rawValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension HotelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isUsingMockData {
            return viewModel.numberOfItens()
        } else {
            return viewModel.isLoading ? viewModel.skeletonCount : viewModel.localPhotos.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        
        if viewModel.isUsingMockData {
            let hotelImage = viewModel.getHotelList()[indexPath.row]
            if let image = UIImage(named: hotelImage) {
                cell.hideSkeleton()
                cell.setupCell(image: image)
            }
        } else {
            if viewModel.isLoading {
                cell.showSkeleton()
            } else {
                cell.hideSkeleton()
                cell.setupCell(image: viewModel.localPhotos[indexPath.row])
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)
    }
}

extension HotelViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.findHotel(typed: searchBar.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.infoToSearchLabel.alpha = 0
            } completion: {_ in
                UIView.animate(withDuration: 0.5) {
                    if self.hotelInfoView.alpha == 0 {
                        self.infoToSearchLabel.text = Localized.touchDetailsLabelTitle
                        self.infoToSearchLabel.alpha = 1
                    }
                }
            }
            self.hotelMapView.removeAnnotations(self.hotelMapView.annotations)
            self.viewModel.buildMKPoints(region: self.hotelMapView.region)
        }
    }
}

extension HotelViewController: MKMapViewDelegate {
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
            let stringFinal = "\(Localized.titleHotelView),\(placeName),\(regionTyped ?? "")"

            viewModel.isLoading = true
            viewModel.searchEstabilishment(value: stringFinal, filter: filter)
        }
    }
}


