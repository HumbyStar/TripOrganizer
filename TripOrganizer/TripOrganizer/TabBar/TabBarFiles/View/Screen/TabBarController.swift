//
//  TabBarController.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.init(red: 81/255, green: 157/255, blue: 149/255, alpha: 1.0)
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        guard let items = tabBar.items else { return }

        items[0].image = UIImage(systemName: "house.fill")
        items[0].title = "Home"
        items[1].image = UIImage(systemName: "airplane")
        items[1].title = "Voos"
        items[2].image = UIImage(systemName: "bed.double.fill")
        items[2].title = "Hotel"
        items[3].image = UIImage(systemName: "fork.knife")
        items[3].title = "Restaurante"
        items[4].image = UIImage(systemName: "heart.fill")
        items[4].title = "Lazer"
        
    }
}



