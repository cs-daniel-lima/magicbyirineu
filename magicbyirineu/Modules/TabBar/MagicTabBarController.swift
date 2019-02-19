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
        
        let cardsBarItem = UITabBarItem(title: "Cards", image: nil, tag: 0)
        let favoritesBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        firstViewController.tabBarItem = cardsBarItem
        secondViewController.tabBarItem = favoritesBarItem
        
        viewControllers = [firstViewController, secondViewController]
        
        let backgroundBar = UIImage(color: .clear, size: tabBar.frame.size)
        
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundImage = backgroundBar
        
        setupTabBarItem(item: cardsBarItem)
        setupTabBarItem(item: favoritesBarItem)
        
    }
    
    func setupTabBarItem(item:UITabBarItem){
        
        let tabbarFont = UIFont(name: "SFProDisplay-Bold", size: 16)
        
        item.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: tabbarFont as Any
            ], for: UIControl.State.normal)
        
        item.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor(red:0.73, green:0.73, blue:0.78, alpha:1.0),
            NSAttributedString.Key.font: tabbarFont as Any
            ], for: UIControl.State.selected)
        
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
    }
    
}
