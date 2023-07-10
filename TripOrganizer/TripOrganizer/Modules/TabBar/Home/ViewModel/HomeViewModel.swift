//
//  HomeViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func reloadTableView()
    func error()
}

class HomeViewModel {
    
    var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    private var tripImages: [String] = ["trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3"]
    
    private var fireStoreManager = FirestoreManager.shared
    
    public func fetchRequest() {
        fireStoreManager.getObjectData(collection: "user", forObjectType: User.self) { result in
            switch result {
            case .success(let user):
                HomeViewModel.tripList = user.trip ?? []
                self.delegate?.reloadTableView()
            case .failure(let error):
                print(error)
                self.delegate?.error()
            }
        }
    }
    

    private static var tripList: [AddTripModel] = []{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name("updateList"), object: nil)
        }
    }
    
    var tripNumberOfRows: Int {
        HomeViewModel.tripList.endIndex
    }
    
    
    public func getTripList()-> Int{
        HomeViewModel.tripList.count
    }
    public func getListTripImages(index: Int) -> String {
        tripImages[index]
    }
    
    public func getTripList(index: Int) -> AddTripModel {
        return HomeViewModel.tripList[index]
    }
    
    public func removeTrip(index: Int) {
        HomeViewModel.tripList.remove(at: index)
    }
    
    public func appendTripToList(trip: AddTripModel) {
        HomeViewModel.tripList.append(trip)

    }
        
    public func getProfileImageSelected(notification: Notification, perfilButton: UIButton){
        if let selectedImage = notification.object as? UIImage {
            perfilButton.setImage(selectedImage, for: .normal)
        }
    }
}

