//
//  AttractionViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 19/04/23.
//

import UIKit

class AttractionViewModel {
    
    private let locationImagelist: [AttractionModel] = [AttractionModel(attractionImage:"1", ratings: "Avaliações", name: "Praça do Japão", address: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phoneNumber: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                        AttractionModel(attractionImage:"2", ratings: "Avaliações", name: "Praça do Japão", address: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phoneNumber: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                        AttractionModel(attractionImage:"3", ratings: "Avaliações", name: "Praça do Japão", address: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phoneNumber: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                        AttractionModel(attractionImage:"4", ratings: "Avaliações", name: "Praça do Japão", address: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phoneNumber: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito"),
                                                        AttractionModel(attractionImage:"5", ratings: "Avaliações", name: "Praça do Japão", address: "Avenida Silva Jardim, 2487 - Agua Verde", openingHours: "Horário: Abre as 12:00", phoneNumber: "Telefone: (41)2344-7498", entranceFee: "Taxa de Entrada: Gratuito")]
    
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
    
    public func getCornerRadius(value: CGFloat) -> CGFloat {
        return value
    }
    
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
            return CGSize(width: 140, height: height - 20)
        }
    
    public func  getCornerRadiusCell() -> CGFloat {
        return 10
    }
    
    public func getCornerRadius()-> CGFloat {
       return 12
    }
}
