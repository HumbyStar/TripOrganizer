//
//  HomeViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

class HomeViewModel {
    
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

