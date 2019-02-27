//
//  CardListViewControllerSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 26/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class CardListViewControllerSpec:QuickSpec{
    
    override func spec() {
        
        var sut:CardListViewController!
        
        beforeEach {
            sut = CardListViewController(title: "CardList")
            UIApplication.shared.keyWindow?.rootViewController = sut
        }
        
        context("when it is initialized"){
            it("should view match with snapshot"){
                
                expect(sut) == snapshot()
                
            }
        }
        
        
        
    }
}
