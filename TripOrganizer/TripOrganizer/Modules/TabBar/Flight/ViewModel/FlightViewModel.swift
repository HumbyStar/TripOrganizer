//
//  FlightViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

protocol FlightModelProtocol: AnyObject {
    func showTicketsViewController()
}

class FlightViewModel {
    
    weak var delegate: FlightModelProtocol?
    
    public func delegate(delegate: FlightModelProtocol) {
        self.delegate = delegate
    }
    
    private var service: FlightService = FlightService()
    private var ticketList: [Ticket]?
    private var listObject: [FlightModel] = [FlightModel(cityNameObject: "Florianópolis", cityDescriptionObject: "Conhecida por suas praias     paradisíacas,                                    Floripa também é famosa por sua culinária e por apresentar uma cultura     vibrante.",cityImageObject: "floripa" ),
                                             FlightModel(cityNameObject: "Rio de Janeiro", cityDescriptionObject: "Famosa por suas praias, Cristo Redentor e pelo Pão de Açúcar. Também conhecida pelas grandes favelas e o Carnaval.", cityImageObject:  "rioDeJaneiro"),
                                             FlightModel(cityNameObject: "Fernando de Noronha", cityDescriptionObject: "Arquipélago reconhecido pelas suas praias pouco urbanizadas e por atividades como mergulho e snorkeling.", cityImageObject:  "noronha" ),
                                             FlightModel(cityNameObject: "Belo Horizonte", cityDescriptionObject: "Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão e a lagoa da Pampulha.", cityImageObject:  "bh"),
                                             FlightModel(cityNameObject: "Porto Alegre", cityDescriptionObject: "Capital do estado de Rio Grande do Sul, no sul do Brasil. Na praça principal, a Praça Marechal Deodoro, encontra-se a Catedral.", cityImageObject: "pa")]
    
    private func sortedArray() {
        
    }
    
    public var getListObject: Int {
        return listObject.endIndex
    }
    
    public var getNumberTicketList: Int? {
        return ticketList?.endIndex
    }
    
    public func getTicketList(index: IndexPath) -> Ticket? {
        return ticketList?[index.row]
    }
    
    public func getListObjectCellForItemAt(index: IndexPath) -> FlightModel {
        return listObject[index.row]
    }
    
    public func sizeForItem(IndexPath: IndexPath, frame: CGRect, height: CGFloat, collectionView: UICollectionView) -> CGSize{
        return CGSize(width: collectionView.frame.size.width * 0.8, height: collectionView.frame.size.height)
    }
    
    public func getConfigLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    public func getValidationTextFieldShouldReturn(textField: UITextField,flightOriginTextField: UITextField,flightDestinationTextField: UITextField, passengersTextField: UITextField ) -> Bool {
        if textField == flightOriginTextField {
            flightDestinationTextField.becomeFirstResponder()
        } else if textField == passengersTextField{
            passengersTextField.resignFirstResponder()
        }
        return true
    }
    
    public func fetchRequest(origin: String, destination: String, onGoingDate: Date, returnDate: Date, numberOfPassengers: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedOnGoingDate = dateFormatter.string(from: onGoingDate)
        let formattedReturnDate = dateFormatter.string(from: returnDate)
        
        let urlString = "https://skyscanner50.p.rapidapi.com/api/v1/searchFlights?origin=\(origin)&destination=\(destination)&date=\(formattedOnGoingDate)&adults=\(numberOfPassengers)&currency=BRL&countryCode=US&market=en-US&returnDate=\(formattedReturnDate)"
        
        service.getFlight(url: urlString) { flights, error in
            if error != nil {
                print("Deu ruim!! erro na hora de ler sua URL")
            } else {
                self.ticketList = flights?.data
                self.delegate?.showTicketsViewController()
            }
        }
    }
}

