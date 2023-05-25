//
//  TabBarController.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

enum TabBarTitles: String {
    case home = "Home"
    case airplane = "Voos"
    case hotel = "Hotel"
    case restaurant = "Restaurante"
    case attraction = "Lazer"
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.tabColor
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        guard let items = tabBar.items else { return }

        //MARK: - Tab Bar Itens
        items[0].title = TabBarTitles.home.rawValue
        items[1].title = TabBarTitles.airplane.rawValue
        items[2].title = TabBarTitles.hotel.rawValue
        items[3].title = TabBarTitles.restaurant.rawValue
        items[4].title = TabBarTitles.attraction.rawValue
        
        //MARK: - Tab bar Images
        items[0].image = UIImage(systemName: Localized.home)
        items[1].image = UIImage(systemName: Localized.airplane)
        items[2].image = UIImage(systemName: Localized.hotel)
        items[3].image = UIImage(systemName: Localized.restaurant)
        items[4].image = UIImage(systemName: Localized.attraction)
        
    }
}



