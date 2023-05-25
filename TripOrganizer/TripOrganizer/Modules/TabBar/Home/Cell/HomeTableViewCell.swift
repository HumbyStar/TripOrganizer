//
//  CustomTableViewCell.swift
//  RefazendoHomeTripOrganizer
//
//  Created by Felipe Augusto Correia on 22/04/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var departureDateLabel: UILabel!
    @IBOutlet var returnDateLabel: UILabel!
    
    static let identifier: String = String(describing: HomeTableViewCell.self)
    
    static public func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        self.contentView.layer.cornerRadius = 8
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configCellLayout()
        self.configImageView()
    }
    
    private func configCellLayout() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.contentView.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
    
    
    private func configImageView() {
        self.placeImageView.clipsToBounds = true
        self.placeImageView.layer.cornerRadius = 8
    }
    
    public func setupCell(trip: AddTripModel) {
        tripNameLabel.text = trip.tripName
        departureDateLabel.text = trip.departureDate
        returnDateLabel.text = trip.returnDate
    }
    
}
