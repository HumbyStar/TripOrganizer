//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import Foundation

class HotelCellViewModel {
    
    private var hotelList: [Image] = [Image(nameImages: "imagehotel"), Image(nameImages: "hotel1"), Image(nameImages: "hotel2")]
    
    public func hotelNumberOfItemsInSection() -> Int {
        hotelList.count
    }
    
    public func hotelCellForItemAt(index: Int) -> Image {
        hotelList[index]
    }
}
