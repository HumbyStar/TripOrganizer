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
    private var listObjectSecondFlightScreen: [Flight] = []
    
    public func getListObjectSecondFlightScreenCellForItemAt(index: Int) -> Flight{
        return listObjectSecondFlightScreen[index]
    }
    
    public func getHeightForRowAt() -> CGFloat{
        return 230
    }
    
    var getNumberOfRowsInSection: Int {
        ticketList.endIndex
    }
    
}
