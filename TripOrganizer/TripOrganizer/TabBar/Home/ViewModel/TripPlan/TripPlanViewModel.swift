//
//  TripPlanViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 25/04/23.
//

import UIKit

class TripPlanViewModel {

    private var placeList: [TripPlanModel] = [TripPlanModel(placeName: "Coliseum", placeImageName: "teste3"),
                              TripPlanModel(placeName: "Paris", placeImageName: "teste2"),
                              TripPlanModel(placeName: "Restaurante", placeImageName: "restaurante1"),
                              TripPlanModel(placeName: "Restaurante", placeImageName: "restaurante2"),
                              TripPlanModel(placeName: "Hotel", placeImageName: "hotel1"),
                              TripPlanModel(placeName: "Hotel", placeImageName: "hotel2"),
                              TripPlanModel(placeName: "Hotel", placeImageName: "imagehotel")
                            
    ]
    
    public func getListItens(index: Int) -> TripPlanModel {
        placeList[index]
    }
    
    
    public func getNumberList() -> Int {
        return placeList.count
    }
    
    
}
