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
        
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "airplane")
        items[2].image = UIImage(systemName: "bed.double.fill")
        items[3].image = UIImage(systemName: "fork.knife")
        items[4].image = UIImage(systemName: "play.fill")
        
    }
}



