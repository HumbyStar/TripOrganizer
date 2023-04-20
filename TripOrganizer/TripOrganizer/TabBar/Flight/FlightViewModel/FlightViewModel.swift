//
//  FlightViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class FlightViewModel {
    
    private var listObject: [FlightModel] = [FlightModel(cityNameObject: "Florianópolis", cityDescriptionObject: "Conhecida por suas praias paradisíacas,                                    Floripa também é famosa por sua culinária e por apresentar uma cultura vibrante.", cityImageObject: "floripa"),
                                             FlightModel(cityNameObject: "Rio de Janeiro", cityDescriptionObject: "Famosa por suas praias, Cristo Redentor e pelo Pão de Açúcar. Também conhecida pelas grandes favelas e o Carnaval.", cityImageObject:  "rioDeJaneiro"),
                                             FlightModel(cityNameObject: "Fernando de Noronha", cityDescriptionObject: "Arquipélago reconhecido pelas suas praias pouco urbanizadas e por atividades como mergulho e snorkeling.", cityImageObject:  "noronha" ),
                                             FlightModel(cityNameObject: "Belo Horizonte", cityDescriptionObject: "Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão e a lagoa da Pampulha.", cityImageObject:  "bh"),
                                             FlightModel(cityNameObject: "Porto Alegre", cityDescriptionObject: "Capital do estado de Rio Grande do Sul, no sul do Brasil. Na praça principal, a Praça Marechal Deodoro, encontra-se a Catedral.", cityImageObject: "pa")]
    
    
    public func getListObject() -> Int{
        return listObject.count
    }
    
    
    public func getListObjectCellForItemAt(index: Int) -> FlightModel{
        return listObject[index]
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
        
        
        //    public func getCityImages(indexPath: IndexPath) -> [String]{
        //        return listObject[indexPath.row].cityImageObject
        //    }
        
        // FlightModel(cityNameObject:"Rio de Janeiro"),
        //                                   FlightModel(cityNameObject:"Fernando de Noronha"),
        //                                   FlightModel(cityNameObject:"Belo Horizonte"),
        //                                   FlightModel(cityNameObject:"Porto Alegre")]
        //FlightModel(cityNameObject:"Florianópolis")
        //
        //    var cityDescription: [FlightModel] = ["Conhecida por suas praias paradisíacas, Floripa também é famosa por sua culinária e por apresentar uma cultura vibrante.", "Famosa por suas praias, Cristo Redentor e pelo Pão de Açúcar. Também conhecida pelas grandes favelas e o Carnaval.", "Arquipélago reconhecido pelas suas praias pouco urbanizadas e por atividades como mergulho e snorkeling.", "Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão e a lagoa da Pampulha.", "Capital do estado de Rio Grande do Sul, no sul do Brasil. Na praça principal, a Praça Marechal Deodoro, encontra-se a Catedral."]
        //
        //    var cityImage: [FlightModel] = ["floripa", "rioDeJaneiro", "noronha", "bh", "pa"]
        //
    
}
