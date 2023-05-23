//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

class TripPlanViewModel {
    
    private var placeList: [TripPlanModel] = [TripPlanModel(name: "Coliseum", images: "teste3"),
                                              TripPlanModel(name: "Paris", images: "teste2"),
                                              TripPlanModel(name: "Restaurante", images: "restaurante1"),
                                              TripPlanModel(name: "Restaurante", images: "restaurante2"),
                                              TripPlanModel(name: "Hotel", images: "hotel1"),
                                              TripPlanModel(name: "Hotel", images: "hotel2"),
                                              TripPlanModel(name: "Hotel", images: "imagehotel")
                                              
    ]
    
    public func getPlaceList(index: Int) -> TripPlanModel {
        placeList[index]
    }
    
    
    public func getNumberList() -> Int {
        return placeList.endIndex
    }
    
}
