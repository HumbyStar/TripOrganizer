//
//  SecondFlightViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class TicketsViewModel {
    
    private var ticketList: [Ticket] = []
    private var service: FlightService = FlightService()
    private var listObjectSecondFlightScreen: [FlightModel] = []
    
    
    public func getListObjectSecondFlightScreenCellForItemAt(index: Int) -> FlightModel{
        return listObjectSecondFlightScreen[index]
    }
    
    public func getHeightForRowAt() -> CGFloat{
        return 230
    }
    
    public func getNumberOfRowsInSection() -> Int {
        return 10
    }
}
