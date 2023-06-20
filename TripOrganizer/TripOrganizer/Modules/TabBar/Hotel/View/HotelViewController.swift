//
//  HotelVC.swift
//  TripOrganizer


import UIKit
import MapKit
import GooglePlaces

enum messageAlertHotel: String {
    case title = ""
    case addHotel = "Hotel adicionado com sucesso a sua lista de viagem!"
}

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
    
    public var viewModel: HotelViewModel = HotelViewModel()
    var alert: Alert?
    var localPhotos: [UIImage] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewDidLoad() {
        self.alert = Alert(controller: self)
        super.viewDidLoad()
        hotelMapView.delegate = self
        configHotelMapView()
        configHotelInfoView()
        configSearchBar()
        configButton()
        setupUI()
        
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
        
        viewModel.alertHandler = {
            self.alert?.createAlert(title: "Erro", message: "Não existe informações do lugar selecionado")
        }
        
        viewModel.completion = { [weak self] localDetail in
            guard let self = self else {return}
            
            if self.viewInfoHeight.constant == 153 {
                self.displayDetailsScreen(local: localDetail)
                self.showView(check: true)
                self.updateCollectionView()
            } else {
                self.changePlaceAnimated(infoPlace: localDetail)
            }
        }
        
    }
    
    private func changePlaceAnimated(infoPlace: GMSPlace) {
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
        
        //viewModel.fetchHotels()
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
    
    private func displayDetailsScreen(local: GMSPlace) {
        hotelNameLabel.text = local.name
        hotelAddressLabel.text = local.formattedAddress
        
        if local.phoneNumber != nil {
            hotelPhoneNumberLabel.text = "Contato: \(local.phoneNumber ?? "")"
        } else {
            hotelPhoneNumberLabel.text = "Contato: Indisponível"
        }
        
        hotelRatingLabel.text = "Avaliações - \(local.rating)"

        hotelOpeningHoursLabel.text = viewModel.checkLocalHour(dataHour: local.isOpen())
        
        guard let photos = local.photos else {
            print("Não foi possível recuperar fotos")
            return
        }
        
        viewModel.loadLocalPhotos(photos: photos)
        self.collectionView.reloadData()
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
    
    private func setupUI(){
        hotelRatingLabel.text = Localized.assessmentsTitle.localized
        hotelAddressLabel.text = Localized.addressTitle.localized
        hotelOpeningHoursLabel.text = Localized.timeTitle.localized
        hotelPhoneNumberLabel.text = Localized.phoneTitle.localized
        accommodationLabel.text = Localized.accommodationTitle.localized
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
        return viewModel.localPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell else {
            return UICollectionViewCell()
        }
        //let images = viewModel.getHotelImages(indexPath: indexPath)
        cell.setupCell(image: viewModel.localPhotos[indexPath.row])
        cell.layer.cornerRadius = 10
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
                        self.infoToSearchLabel.text = "Digite em um icone para ver os detalhes"
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

            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            let stringFinal = "Hotel,\(placeName)"

            viewModel.searchEstabilishment(value: stringFinal, filter: filter)
        }
    }
}


