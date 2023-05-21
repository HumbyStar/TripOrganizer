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
        
        view.backgroundColor = UIColor.logoGray
        logoImageView.alpha = 0
        UIView.animate(withDuration: 2, animations: {
            self.logoImageView.alpha = 1
        }) {(_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                let storyBoard = UIStoryboard(name: String.main, bundle: nil)
                let viewController = storyBoard.instantiateInitialViewController()
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let sceneDelegate = windowScene.delegate as? SceneDelegate,
                      let window = sceneDelegate.window else {
                    return
                }
                window.rootViewController = viewController
            }
        }
    }
}

