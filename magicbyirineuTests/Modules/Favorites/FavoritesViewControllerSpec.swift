//
//  FavoritesViewControllerSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 19/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class FavoritesViewControllerSpec:QuickSpec{
    
    override func spec() {
        
        var sut:FavoritesViewController!
        
        beforeEach {
            sut = FavoritesViewController(title: "Favorites")
            UIApplication.shared.keyWindow?.rootViewController = sut
        }
        
        context("when it is initialized"){
            it("should view match with snapshot"){
                
                expect(sut) == snapshot()
                
            }
        }
        
        
        
    }
}
