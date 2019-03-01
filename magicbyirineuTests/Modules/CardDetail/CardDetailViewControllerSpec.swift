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
        
        context("when it is initialized") {
            it("should match view with snapshot"){
                expect(sut) == snapshot()
            }
        }
        
    }
    
}
