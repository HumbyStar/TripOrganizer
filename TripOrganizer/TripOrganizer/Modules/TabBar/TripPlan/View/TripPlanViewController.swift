//
//  TripPlanViewController.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 22/04/23.
//

import UIKit

class TripPlanViewController: UIViewController {

    @IBOutlet var tripImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    var placeNameReceived: String?
    var tripViewModel: TripPlanViewModel = TripPlanViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        configCollectionView()
        configCollectionViewProtocol()
        tripNameLabel.text = placeNameReceived
       // collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configCollectionViewProtocol() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configCollectionView() {
        tripViewModel.configLayoutCollectionView(collectionView: collectionView)
        collectionView.register(TripPlanCollectionViewCell.nib(), forCellWithReuseIdentifier: TripPlanCollectionViewCell.identifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension TripPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripViewModel.getNumberOfItens()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: TripPlanCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TripPlanCollectionViewCell.identifier, for: indexPath) as? TripPlanCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(place: tripViewModel.getObjectList(index: indexPath.row))
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return tripViewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height, view: view)
    }
}
