//
//  PrimaryTabBarViewController.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import UIKit

class PrimaryTabBarViewController: UITabBarController {

   let databaseService = DatabaseServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        
        
    }
    
   private func configureTabBar() {
       let vc1 = HomeViewController(databaseService: databaseService)
        let vc2 = FavouritesViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "shuffle")
        vc2.tabBarItem.image = UIImage(systemName: "heart")
       
       vc1.tabBarItem.title = "Xplore"
       vc2.title = "Favourites"
       
       let nav1 = UINavigationController(rootViewController: vc1)
       let nav2 = UINavigationController(rootViewController: vc2)
       
       tabBar.tintColor = .label
       tabBar.backgroundColor = .systemGray5
       
       setViewControllers([nav1, nav2], animated: true)
    }
}

#Preview {
    PrimaryTabBarViewController()
}
