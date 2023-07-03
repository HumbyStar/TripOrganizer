//
//  LoungeVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import MapKit

enum messageAttraction: String {
    case titleEmpty = ""
    case message = "Lazer adicionado com sucesso a sua lista de viagem!"
}

class AttractionViewController: UIViewController {
    var tripViewModel: TripPlanViewModel = TripPlanViewModel()
    public let attractionViewModel: AttractionViewModel = AttractionViewModel()
    var homeViewModel: HomeViewModel? = HomeViewModel()
    var alert: Alert?
    
    @IBOutlet weak var attractionRatingLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var attractionMapView: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var attractionInfoView: UIView!
    @IBOutlet var addAttractionButton: UIButton!
    @IBOutlet var attractionNameLabel: UILabel!
    @IBOutlet weak var assessmentLabel: UILabel!
    @IBOutlet var attractionAdressLabel: UILabel!
    @IBOutlet var openingHoursLabel: UILabel!
    @IBOutlet var attractionPhoneNumberLabel: UILabel!
    @IBOutlet var entranceFeeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.attractionViewModel.fetchAttractions()
        configSearch()
        configButton()
        configLabel()
        configCollectionView()
        roundedBorder()
        addAttractionButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: Notification.Name("updateList"), object: nil)
        updateButtonState()
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
        openingHoursLabel.text = Localized.timeTitle.localized
        entranceFeeLabel.text = Localized.entranceFeeLabelAttractionLabel.localized
    }
    
    private func configCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        attractionViewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(AttractionCell.nib(), forCellWithReuseIdentifier: AttractionCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    @IBAction func tappedAddAttractionButton(_ sender: UIButton) {
        alert?.createAlert(title: messageAttraction.titleEmpty.rawValue, message: messageAttraction.message.rawValue)
        tripViewModel.addObjectAttraction(object: AttractionModel(name: attractionNameLabel.text ?? "", ratings: attractionRatingLabel.text ?? "", phoneNumber: attractionPhoneNumberLabel.text ?? "", address: attractionAdressLabel.text ?? "", openingHours: openingHoursLabel.text ?? ""))
        
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
        return attractionViewModel.numberOfItens()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AttractionCell = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionCell.identifier, for: indexPath) as? AttractionCell else {
            return UICollectionViewCell()
        }
      //  let images = attractionViewModel.getAttractionImages(indexPath: indexPath)
       // cell.setupCell(image: images[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return attractionViewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height)

    }
}
