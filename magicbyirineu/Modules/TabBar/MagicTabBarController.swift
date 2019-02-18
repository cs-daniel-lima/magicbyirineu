//
//  MagicTabBarController.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicTabBarController: UITabBarController {
    
    let firstViewController = CardListViewController()
    let secondViewController = UIViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTabBar()
        
    }
    
    func setupTabBar(){
        
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers = [firstViewController, secondViewController]
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
