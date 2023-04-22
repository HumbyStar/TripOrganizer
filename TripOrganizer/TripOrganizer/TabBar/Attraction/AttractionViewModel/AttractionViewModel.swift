//
//  AttractionViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class AttractionViewModel {

   private let locationImagelist: [AttractionModel] = [AttractionModel(imageAttraction:"1", assessments: "Avaliações", attractionName: "Praça do Japão", attractionAdress: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phone: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                       AttractionModel(imageAttraction:"1", assessments: "Avaliações", attractionName: "Praça do Japão", attractionAdress: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phone: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                       AttractionModel(imageAttraction:"1", assessments: "Avaliações", attractionName: "Praça do Japão", attractionAdress: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phone: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                       AttractionModel(imageAttraction:"1", assessments: "Avaliações", attractionName: "Praça do Japão", attractionAdress: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phone: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),]
    
    public func getLocationImagelist() -> Int{
        locationImagelist.count
    }
    
    public func getLocationImageListCellForItemAt(index: Int) -> AttractionModel{
        locationImagelist[index]
    }
    
   public func configLayoutCollectionView(collectionView: UICollectionView){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    public func sizeForItem(IndexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
        return CGSize(width: 140, height: height - 20)
    }
    
}
