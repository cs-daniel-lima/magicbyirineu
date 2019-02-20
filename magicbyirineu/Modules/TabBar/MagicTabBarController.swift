//
//  MagicTabBarController.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicTabBarController: UITabBarController {
    
    let tabBarViewControllers:[UIViewController]
    
    init(viewControllers:[UIViewController]){
        self.tabBarViewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarColors()
        setupTabBarBorders()
    }
    
    func setupTabBar(){
        
        for viewController in tabBarViewControllers{
            
            let tabBarItem = UITabBarItem(title: viewController.title, image: nil, selectedImage: nil)
            setupTabBarItem(item: tabBarItem)
            viewController.tabBarItem = tabBarItem
            
        }
        
        viewControllers = tabBarViewControllers
        
    }
    
    func setupTabBarColors(){
        let tabBarBackground = UIImage(color: .clear, size: tabBar.frame.size)
        
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundImage = tabBarBackground
    }
    
    func setupTabBarBorders(){
        
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
        
        print("asdf")
        
    }
    
}
