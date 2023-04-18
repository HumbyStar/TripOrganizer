//
//  Alert.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 17/04/23.
//

import UIKit

class Alert {
    
    var controller: UIViewController?
    
    init(controller: UIViewController? = nil) {
        self.controller = controller
    }
    
    public func createAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(ok)
        self.controller?.present(alertController, animated: true)
    }
}
