//
//  SecondFlightViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class SecondFlightViewModel {
    
    private var listObjectSecondFlightScreen: [FlightModel] = [FlightModel(cityNameObject: "Florianópolis", cityDescriptionObject: "Conhecida por suas praias paradisíacas, Floripa também é famosa por sua culinária e por apresentar uma cultura vibrante.", cityImageObject: "floripa", ticketPrice: "", tripDuration: "",tripStartTime: "", tripEndTime: "" ,locateOrigin: "", locateDestination: "" ),
                                                               FlightModel(cityNameObject: "Rio de Janeiro", cityDescriptionObject: "Famosa por suas praias, Cristo Redentor e pelo Pão de Açúcar. Também conhecida pelas grandes favelas e o Carnaval.", cityImageObject:  "rioDeJaneiro", ticketPrice: "", tripDuration: "",tripStartTime: "", tripEndTime: "" ,locateOrigin: "", locateDestination: "" ),
                                                               FlightModel(cityNameObject: "Fernando de Noronha", cityDescriptionObject: "Arquipélago reconhecido pelas suas praias pouco urbanizadas e por atividades como mergulho e snorkeling.", cityImageObject:  "noronha" , ticketPrice: "", tripDuration: "",tripStartTime: "", tripEndTime: "" ,locateOrigin: "", locateDestination: "" ),
                                                               FlightModel(cityNameObject: "Belo Horizonte", cityDescriptionObject: "Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão e a lagoa da Pampulha.", cityImageObject:  "bh", ticketPrice: "", tripDuration: "",tripStartTime: "", tripEndTime: "" ,locateOrigin: "", locateDestination: "" ),
                                                               FlightModel(cityNameObject: "Porto Alegre", cityDescriptionObject: "Capital do estado de Rio Grande do Sul, no sul do Brasil. Na praça principal, a Praça Marechal Deodoro, encontra-se a Catedral.", cityImageObject: "pa", ticketPrice: "", tripDuration: "",tripStartTime: "", tripEndTime: "" ,locateOrigin: "", locateDestination: "" )]
    
    public func getListObjectSecondFlightScreenCellForItemAt(index: Int) -> FlightModel{
        return listObjectSecondFlightScreen[index]
    }
    
    public func getNumberOfRowsInSection() -> Int{
        return 10
    }
    
    public func getHeightForRowAt() -> CGFloat{
        return 230
    }
    
    public func getDidSelectRowAt(tableView: UITableView, indexPath: IndexPath) -> Void{
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
