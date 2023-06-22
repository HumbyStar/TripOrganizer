//
//  FlightService.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 20/06/23.
//

import Foundation

enum ErrorDetail: Swift.Error {
    case errorURL(urlString: String)
    case detailError(detail: String)
}

class FlightService {
    
    public func getFlight(url: String, completion: @escaping (TicketsModel?, Error?) -> Void) {
        let headers = ["X-RapidAPI-Key": "7ff4a9f926msh5fc948782424c27p16d26fjsn0e934eba019d", "X-RapidAPI-Host": "skyscanner50.p.rapidapi.com"]
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            guard let dataResult = data else { return }
            
            let json = try? JSONSerialization.jsonObject(with: dataResult, options: [])
            print(json)
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                do {
                    let data: TicketsModel = try JSONDecoder().decode(TicketsModel.self, from: dataResult)
                    print("SUCCESS -> \(#function)")
                    completion(data, nil)
                } catch {
                    print("ERROR -> \(error.localizedDescription)")
                    completion(nil, error as? Error)
                }
            } else {
                print("ERROR -> \(#function)")
                completion(nil, error as? Error)
            }
        }.resume()
    }
}

    
    
    //            DispatchQueue.main.async {
    //                if let error {
    //                    completion(.failure(Error.errorURLRequest(error)))
    //                } else {
    //                    guard let data = data else { return }
    //                    do {
    //                        let data: TicketsModel = try JSONDecoder().decode(TicketsModel.self, from: data)
    //                        completion(.success(data))
    //                    } catch let error {
    //                        completion(.failure(Error.errorURLRequest(error)))
    //                    }
    //                }
    //            }
    

