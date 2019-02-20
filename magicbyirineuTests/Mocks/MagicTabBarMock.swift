//
//  MagicTabBarMock.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 19/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation
import UIKit

@testable import magicbyirineu

class MagicTabBarMock: MagicTabBarController {
    
    init(){
        
        super.init(viewControllers: [CardListViewController(title: "Cards"), FavoritesViewController(title: "Favorites")])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setupTabBarIsCalled = false
    var totalCallsToSetupTabBarItem = 0
    
    override func setupTabBar() {
        super.setupTabBar()
        setupTabBarIsCalled = true
    }
    
    override func setupTabBarItem(item: UITabBarItem) {
        super.setupTabBarItem(item: item)
        totalCallsToSetupTabBarItem += 1
    }
    
}
