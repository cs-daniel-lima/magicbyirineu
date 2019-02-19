//
//  MagicTabBarController.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicTabBarController: UITabBarController {
    
    let cardListRouter = CardListRouter()
    let favoritesRouter = FavoritesRouter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTabBar()
        
    }
    
    /**
     Setup the appearance of the tabbar
     */
    func setupTabBar(){
        
        let firstViewController = cardListRouter.presenter.view
        let secondViewController = favoritesRouter.presenter.view
        
        //Items
        let cardsBarItem = UITabBarItem(title: "Cards", image: nil, tag: 0)
        let favoritesBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        //Set items
        firstViewController.tabBarItem = cardsBarItem
        secondViewController.tabBarItem = favoritesBarItem
        
        viewControllers = [firstViewController, secondViewController]
        
        //appearance
        let backgroundBar = UIImage(color: .clear, size: tabBar.frame.size)
        
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundImage = backgroundBar
        
        setupTabBarItem(item: cardsBarItem)
        setupTabBarItem(item: favoritesBarItem)
        
        //borders
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
        
        let topBorder = UIView(frame: CGRect.zero)
        let centerLine = UIView(frame: CGRect.zero)
        
        topBorder.backgroundColor = .white
        centerLine.backgroundColor = .white
        
        tabBar.addSubview(topBorder)
        tabBar.addSubview(centerLine)
        
        topBorder.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(tabBar.frame.size.width * 0.8531)
            make.height.equalTo(1)
        }
        
        centerLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(6.8)
            make.width.equalTo(1)
            make.height.equalTo(28.2)
        }
        
    }
    
    /**
     Setup the appearance of the TabBarItem
     */
    func setupTabBarItem(item:UITabBarItem){
        
        let tabbarFont = UIFont(name: "SFProDisplay-Bold", size: 16)
        
        item.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor(red:0.73, green:0.73, blue:0.78, alpha:1.0),
            NSAttributedString.Key.font: tabbarFont as Any
            ], for: UIControl.State.normal)
        
        item.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: tabbarFont as Any
            ], for: UIControl.State.selected)
        
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
    }
    
}
