//
//  PlaceService.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 04/06/23.
//

import Foundation
import UIKit

class PlaceService {
    
    func getPlaceDataJson(completion: @escaping (PlacesData?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: "PlacesData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let placeData: PlacesData = try JSONDecoder().decode(PlacesData.self, from: data)
                completion(placeData, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
