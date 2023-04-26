//
//  LaunchScreenViewController.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 26/04/23.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = UIColor.logoCinza
        
        // MARK: ANIMAÇÃO DA IMAGEM COM DURAÇÃO, DELAY E ALTERAÇÃO DA COR DO BACKGROUND:
        logoImageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            self.logoImageView.alpha = 1
        }) { (succes) in
            
            // MARK: ADICIONA O DELAY DE 1 SEGUNDO ANTES DE SEGUIR PARA A TELA LOGIN:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
            // MARK: SEGUE PARA A TRANSIÇÃO DE TELA, APÓS O DELAY:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateInitialViewController()
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else {
                return
            }
            
            //MARK: rootViewController que seguirá na tela (vc/main)
            window.rootViewController = vc
            }
        }
    }
}

