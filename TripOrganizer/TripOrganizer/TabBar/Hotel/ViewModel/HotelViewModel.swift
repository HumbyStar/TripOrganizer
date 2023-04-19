//
//  HotelViewModel.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 18/04/23.
//

import UIKit

class HotelViewModel {
    
  private  var listRoom: [HotelModel] = [HotelModel(room: "quarto01"), HotelModel(room: "quarto02"), HotelModel(room: "quarto03"),HotelModel(room: "quarto01"), HotelModel(room: "quarto02"), HotelModel(room: "quarto03"),HotelModel(room: "quarto01"), HotelModel(room: "quarto02"), HotelModel(room: "quarto03")]
    
    public func getListRoom() -> Int{
        listRoom.count
    }
    
    public func getListRoomCellForItemAt(index: Int) -> HotelModel{
        listRoom[index]
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
