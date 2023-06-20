//
//  FlightService.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

class FlightService {
    
    private func getFlight(origin: String, destination: String, date: String, numberOfPassengers: String, returnDate: String, completion: @escaping (Result<TicketsModel, Error>) -> Void) {
        let headers = ["X-RapidAPI-Key": "7ff4a9f926msh5fc948782424c27p16d26fjsn0e934eba019d", "X-RapidAPI-Host": "skyscanner50.p.rapidapi.com"]
        
        let urlString = "https://skyscanner50.p.rapidap .com/api/v1/searchFlights?origin=\(origin)&destination=\(destination)&date=\(date)&adults=\(numberOfPassengers)&currency=BRL&countryCode=US&market=en-US&returnDate=\(returnDate)"
        
//        let formattedUrlString = String(format: urlString, origin, destination, date, numberOfPassengers, returnDate)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = NSMutableURLRequest(url: url,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                
                if let error {
                    completion(.failure(Error.errorURLRequest(error)))
                } else {
                    
                    guard let data = data else { return }
                    
                    do {
                        let data: TicketsModel = try JSONDecoder().decode(TicketsModel.self, from: data)
                        completion(.success(data))
                        
                    } catch let error {
                        completion(.failure(Error.errorURLRequest(error)))
                    }
                }
            }
        })
        .resume()
    }
}
