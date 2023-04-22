//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import UIKit

class HotelViewModel {
    
  private  var listRoom: [HotelModel] = [HotelModel(room: ["quarto01","quarto02","quarto03","quarto01","quarto02","quarto03","quarto01","quarto02","quarto03"],nomeHotel: "Chatolamour", avaliacoes: "Avaliações", telefoneHotel: "Telefone: (41) 3243-3430", enderecoHotel: "Av. Silva Jardim, 2487 - Água Verde, Curitiba - PR, 80240-020", horarioHotel: "Horario: abre as 12:00 ")]
    
    public func getListRoom() -> Int{
        listRoom.count
    }
    
    public func getListRoomCellForItemAt(index: Int) -> HotelModel{
        listRoom[index].room
    }
    
    public func configLayoutCollectionView(collectionView: UICollectionView){
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            
        }
    }
   
    public func sizeForItem(indexPath: IndexPath, frame: CGRect, height: CGFloat) -> CGSize {
        return CGSize(width: 140, height: height - 20)
    }
    
    
}
