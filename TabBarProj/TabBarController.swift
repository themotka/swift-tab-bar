//
//  TabBarController.swift
//  less1
//
//  Created by Aleksandr Grachev on 14.10.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        let tableController = TableViewController()
        let collectionController = CollectionViewController()
        
        
        tableController.tabBarItem = UITabBarItem(title: "table", image: UIImage(systemName: "square.split.1x2"), tag: 2)
        collectionController.tabBarItem = UITabBarItem(title: "collection", image: UIImage(systemName: "rectangle.split.3x3.fill"), tag: 3)
        
        viewControllers = [tableController, collectionController]
    }
}
