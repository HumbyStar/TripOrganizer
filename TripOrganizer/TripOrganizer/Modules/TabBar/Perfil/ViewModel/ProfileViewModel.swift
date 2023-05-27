//
//  PerfilViewModel.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    public func getCircleBorderImageView(profileImageView: UIImageView){
        profileImageView.layer.cornerRadius = min(profileImageView.frame.width, profileImageView.frame.height) / 2
        profileImageView.clipsToBounds = true
    }
    
}

