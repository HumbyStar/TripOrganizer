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
        tabBar.tintColor = .systemBlue
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "Home")
        items[1].image = UIImage(named: "airplane")
        items[2].image = UIImage(named: "cama")
        items[3].image = UIImage(named: "Restaurant")
        items[4].image = UIImage(named: "Eiffel Tower")
        
    }
}



