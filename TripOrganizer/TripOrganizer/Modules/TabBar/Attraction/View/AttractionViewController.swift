//
//  LoungeVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit
import GooglePlaces

enum messageAttraction: String {
    case titleEmpty = ""
    case message = "Lazer adicionado com sucesso a sua lista de viagem!"
}

class AttractionViewController: UIViewController {
    @IBOutlet weak var attractionRatingLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var attractionMapView: MKMapView!
    @IBOutlet var attractionInfoView: UIView!
    @IBOutlet var addAttractionButton: UIButton!
    @IBOutlet var attractionNameLabel: UILabel!
    @IBOutlet weak var assessmentLabel: UILabel!
    @IBOutlet var attractionAdressLabel: UILabel!
    @IBOutlet var attractionOpeningHourLabel: UILabel!
    @IBOutlet var attractionPhoneNumberLabel: UILabel!
    @IBOutlet var entranceFeeLabel: UILabel!
    @IBOutlet weak var viewInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var infoToSearchLabel: UILabel!
    
    private let viewModel: AttractionViewModel = AttractionViewModel()
    var alert: Alert?
    var homeViewModel: HomeViewModel? = HomeViewModel()
    var tripViewModel: TripPlanViewModel = TripPlanViewModel()
    
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
        configBackgroud()
        configSearch()
        configButton()
        configLabel()
        configCollectionView()
        roundedBorder()
        
        viewModel.regionUpdaterHandler = {[weak self] (region) in
            guard let self = self else {return}
            self.attractionMapView.setRegion(region, animated: true)
        }
        
        viewModel.annotationUpdateHandler = {[weak self] (annotations) in
            print(annotations)
            self?.attractionMapView.removeAnnotations(self?.attractionMapView.annotations ?? [])
            self?.attractionMapView.addAnnotations(annotations)
            self?.attractionMapView.showAnnotations(annotations, animated: true)
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: Notification.Name("updateList"), object: nil)
                updateButtonState()
    }
    
    private func updateCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        attractionInfoView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: entranceFeeLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: attractionInfoView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: attractionInfoView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: attractionInfoView.bottomAnchor).isActive = true
    }
    
    private func configBackgroud() {
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    private func displayDetailsScreen(local: PlaceData) {
        switch local {
        case .attractionModel(let attraction):
            attractionPhoneNumberLabel.text = attraction[0].phoneNumber
            assessmentLabel.text = attraction[0].ratings
            attractionNameLabel.text = attraction[0].name
            attractionOpeningHourLabel.text = attraction[0].openingHours
            attractionAdressLabel.text = attraction[0].address
            
        case .gmsPlace(let gmsAttraction):
            if gmsAttraction.phoneNumber != nil {
                attractionPhoneNumberLabel.text = "\(Localized.contactLabelTitle) \(gmsAttraction.phoneNumber ?? "")"
            } else {
                attractionPhoneNumberLabel.text = Localized.invalidContact
            }
            
            assessmentLabel.text = "\(Localized.ratingLabelTitle) \(gmsAttraction.rating)"
            attractionOpeningHourLabel.text = viewModel.checkLocalHour(dataHour: gmsAttraction.isOpen())
            attractionNameLabel.text = gmsAttraction.name
            attractionAdressLabel.text = gmsAttraction.formattedAddress
            
            guard let photos = gmsAttraction.photos else {
                viewModel.loadLocalPhotos(photos: nil)
                return
            }
            
            viewModel.loadLocalPhotos(photos: photos)
            self.collectionView.reloadData()
            
        default:
            break
        }

    }
    
    private func changePlaceAnimated(infoPlace: PlaceData) {
        UIView.animate(withDuration: 0.6) {
            self.attractionNameLabel.alpha = 0
            self.assessmentLabel.alpha = 0
            self.attractionAdressLabel.alpha = 0
            self.attractionPhoneNumberLabel.alpha = 0
            self.attractionOpeningHourLabel.alpha = 0
            self.entranceFeeLabel.alpha = 0
            self.collectionView.alpha = 0
            self.addAttractionButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.4) {
                self.displayDetailsScreen(local: infoPlace)
                self.attractionNameLabel.alpha = 1
                self.attractionRatingLabel.alpha = 1
                self.attractionAdressLabel.alpha = 1
                self.attractionPhoneNumberLabel.alpha = 1
                self.attractionOpeningHourLabel.alpha = 1
                self.entranceFeeLabel.alpha = 1
                self.collectionView.alpha = 1
                self.addAttractionButton.alpha = 1
            }
        }
    }
    
    private func showView(check: Bool) {
        if check {
            self.viewInfoHeight.constant = 315
        } else {
            self.viewInfoHeight.constant = 153
        }
        
        UIView.animate(withDuration: 0.8) {
            self.attractionInfoView.backgroundColor = .white
            self.attractionInfoView.alpha = 1
            self.infoToSearchLabel.alpha = 0
            self.attractionInfoView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    private func roundedBorder() {
        attractionMapView.layer.cornerRadius = 12
        attractionInfoView.layer.cornerRadius = 12
    }
    
    private func configSearch() {
        searchBar.placeholder = Localized.searchPlaceholderAttraction.localized
    }
    
    private func configButton() {
        addAttractionButton.setTitle(Localized.addButtonTitle.localized, for: .normal)
    }
    
    private func configLabel() {
        assessmentLabel.text = Localized.assessmentsTitle.localized
        attractionAdressLabel.text = Localized.addressTitle.localized
        attractionPhoneNumberLabel.text = Localized.phoneTitle.localized
        attractionOpeningHourLabel.text = Localized.timeTitle.localized
        entranceFeeLabel.text = Localized.entranceFeeLabelAttractionLabel.localized
    }
    
    private func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        viewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(AttractionCell.nib(), forCellWithReuseIdentifier: AttractionCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    @IBAction func tappedAddAttractionButton(_ sender: UIButton) {
        guard let image = viewModel.localPhotos.first,
              let imageData = image.pngData() else {
            
            return
        }
        alert?.createAlert(title: messageAttraction.titleEmpty.rawValue, message: messageAttraction.message.rawValue)
        
        tripViewModel.addObjectAttraction(object: ObjectPlaces(images: imageData, name: attractionNameLabel.text ?? "", ratings: attractionRatingLabel.text ?? "", phoneNumber: attractionPhoneNumberLabel.text ?? "", address: attractionAdressLabel.text ?? "", openingHours: attractionOpeningHourLabel.text ?? "" ))

                NotificationCenter.default.post(name: NSNotification.Name("updateProgressBarAttraction"), object: nil)
    }
    
    @objc func updateButtonState() {
            if homeViewModel?.getTripList() != 0 {
                addAttractionButton.isEnabled = true
                } else {
                    addAttractionButton.isEnabled = false
                }
            }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionCell.identifier, for: indexPath) as? AttractionCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        
        if viewModel.isUsingMockData {
            let restaurantImage = "banana"//viewModel.getAttractionImageList()[indexPath.row]
            if let image = UIImage(named: restaurantImage) {
                cell.hideSkeleton()
                cell.setupCell(image: image)
            }
        } else {
            if viewModel.isLoading {
                cell.showSkeleton()
            } else {
                cell.hideSkeleton()
             //   viewModel.localPhotos.isEmpty ? cell.setupCell(image: UIImage(named: viewModel.getAttractionImageList()[indexPath.row]) ?? UIImage()) :
                cell.setupCell(image: viewModel.localPhotos[indexPath.row])
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)

    }
}

extension AttractionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.findAttraction(typed: searchBar.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.infoToSearchLabel.alpha = 0
            } completion: {_ in
                UIView.animate(withDuration: 0.5) {
                    if self.attractionInfoView.alpha == 0 {
                        self.infoToSearchLabel.text = Localized.touchDetailsLabelTitle
                        self.infoToSearchLabel.alpha = 1
                    }
                }
            }
            self.attractionMapView.removeAnnotations(self.attractionMapView.annotations)
            self.viewModel.buildMKPoints(region: self.attractionMapView.region)
        }
    }
}

extension AttractionViewController: MKMapViewDelegate {
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
            let stringFinal = "\(Localized.titleAttractionView),\(placeName),\(regionTyped ?? "")"

            viewModel.isLoading = true
            viewModel.searchEstabilishment(value: stringFinal, filter: filter)
        }
    }
}
