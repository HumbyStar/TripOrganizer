//
//  RecoverPasswordUIViewControler.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 08/03/23.
//

import UIKit

class RecoverViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func voltarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
