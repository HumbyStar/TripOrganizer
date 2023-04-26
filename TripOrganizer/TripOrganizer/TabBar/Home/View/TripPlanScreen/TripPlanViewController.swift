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
    var viewModel: TripPlanViewModel = TripPlanViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        configCollectionView()
        configCollectionViewProtocol()
        tripNameLabel.text = placeNameReceived
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configCollectionViewProtocol() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 30
        }
        collectionView.register(TripPlanCollectionViewCell.nib(), forCellWithReuseIdentifier: TripPlanCollectionViewCell.identifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension TripPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TripPlanCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: TripPlanCollectionViewCell.identifier, for: indexPath) as? TripPlanCollectionViewCell
        cell?.setupCell(place: viewModel.getItemList(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 70, height: 150)
    }
}
