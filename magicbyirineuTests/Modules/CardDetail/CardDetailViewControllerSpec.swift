//
//  CardDetailViewControllerSpec.swift
//  magicbyirineuTests
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class CardDetailViewControllerSpec: QuickSpec{
    
    override func spec() {
        var sut: CardDetailViewControllerMock!
        
        beforeEach {
            sut = CardDetailViewControllerMock()
            UIApplication.shared.keyWindow?.rootViewController = sut
        }
        
        context("when it is initialized with card as favorite") {
            it("should match view with snapshot"){
                sut.screen.favoriteButton.setFavorite(isFavorite: true)
                self.tester().waitForAnimationsToFinish()
                expect(sut.screen.favoriteButton.isFavorite).to(beTrue())
                expect(sut) == snapshot()
            }
        }
        
        context("when it is initialized with card as not favorite ") {
            it("should match view with snapshot", closure: {
                sut.screen.favoriteButton.setFavorite(isFavorite: false)
                self.tester().waitForAnimationsToFinish()
                expect(sut.screen.favoriteButton.isFavorite).notTo(beTrue())
                expect(sut) == snapshot()
            })
            
            
        }
        
    }
    
}
