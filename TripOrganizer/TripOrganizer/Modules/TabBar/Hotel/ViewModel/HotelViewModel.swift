//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import UIKit

class HotelViewModel {
    
    private var roomList: [HotelModel] = [HotelModel(room: "quarto01",name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),HotelModel(room: "quarto02", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),
                                          HotelModel(room: "quarto02", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),
                                          HotelModel(room: "quarto03", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),
                                          HotelModel(room: "quarto01", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),
                                          HotelModel(room: "quarto02", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 "),
                                          HotelModel(room: "quarto03", name: "Chatolamour", ratings: "Avaliações", phoneNumber: "Telefone: (41) 3243-3430", address: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", openingHours: "Horario: abre as 12:00 ")]
    
    
    public func getRoomList() -> Int{
        roomList.endIndex
    }
    
    public func getRoomListCellForItemAt(index: Int) -> HotelModel{
        roomList[index]
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
    
    public func getCollectionViewSize(height: CGFloat, extraNumber: CGFloat) -> Double {
        return height - extraNumber
    }
    
    public func getCollectionViewWidth(width: CGFloat) -> Double {
        return width
    }
    
}
