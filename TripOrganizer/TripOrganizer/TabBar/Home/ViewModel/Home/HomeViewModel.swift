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
    
    
    private var tripList: [AddTripModel] = []
    
    var tripListSize: Int {
        tripList.count
    }
    
    public func getListTripImages(index: Int) -> String {
        tripImages[index]
    }
    
    
    public func getListForCell(index: Int) -> AddTripModel {
        tripList[index]
    }
    
    
    public func getTripList(index: Int) -> AddTripModel {
        return tripList[index]
    }
    
    public func remove(index: Int) {
        tripList.remove(at: index)
    }
    
    public func append(trip: AddTripModel) {
        tripList.append(trip)
    }
}
