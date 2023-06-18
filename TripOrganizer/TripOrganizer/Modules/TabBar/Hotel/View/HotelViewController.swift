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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var hotelInfoView: UIView!
    @IBOutlet weak var accommodationLabel: UILabel!
    @IBOutlet weak var viewInfoDetail: NSLayoutConstraint!
    
    public var viewModel: HotelViewModel = HotelViewModel()
    var alert: Alert?
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        self.alert = Alert(controller: self)
        super.viewDidLoad()
        viewModel.fetchHotels()
        configCollectionView()
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
            self?.hotelMapView.removeAnnotations(self?.hotelMapView.annotations ?? [])
            self?.hotelMapView.addAnnotations(annotations)
            self?.hotelMapView.showAnnotations(annotations, animated: true)
        }
        
        viewModel.alertHandler = {
            self.alert?.createAlert(title: "Erro", message: "Não existe informações do lugar selecionado")
        }
        
//        viewModel.completion = {
//            if self.view
//        }
    }
    
    private func configHotelMapView() {
        hotelMapView.clipsToBounds = true
        hotelMapView.layer.cornerRadius = 12
    }
    
    private func configHotelInfoView() {
        hotelInfoView.clipsToBounds = true
        hotelInfoView.layer.cornerRadius = 12
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(HotelCollectionViewCell.nib(), forCellWithReuseIdentifier: HotelCollectionViewCell.identifier)
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
        return viewModel.numberOfItens()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.identifier, for: indexPath) as? HotelCollectionViewCell else {
            return UICollectionViewCell()
        }
        let images = viewModel.getHotelImages(indexPath: indexPath)
        cell.setupCell(image: images[indexPath.row])
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
            self.hotelMapView.removeAnnotations(self.hotelMapView.annotations)
            self.viewModel.buildMKPoints(region: self.hotelMapView.region)
        }
    }
}

extension HotelViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {return nil}
        
        let identifier = "Annotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
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


