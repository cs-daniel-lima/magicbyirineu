//
//  MagicTabBarControllerSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 19/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class MagicTabBarControllerSpec:QuickSpec{
    
    override func spec() {
        
        var sut:MagicTabBarMock!
        
        beforeEach {
            
            sut = MagicTabBarMock()
            _ = sut.view
            
        }
        
        context("when it is initialized"){
            
            it("setupTabBar should be called"){
                expect(sut.setupTabBarIsCalled).to(beTrue())
            }
            
            it("setupTabBarItem should be called twice"){
                expect(sut.totalCallsToSetupTabBarItem).to(equal(2))
            }
            
            it("first and second viewcontrooler should be defined"){
                expect(sut.viewControllers?.count).to(equal(2))
            }
            
            it("tabbar subview should match with snapshot"){
                //expect(sut.tabBar) == recordSnapshot()
                expect(sut.tabBar) == snapshot()
            }
        }
        
        
        
    }
}
