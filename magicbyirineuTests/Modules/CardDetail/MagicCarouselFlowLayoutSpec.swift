//
//  MagicCarouselFlowLayoutSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 11/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import KIF
import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class MagicCarouselFlowLayoutSpec: QuickSpec {
    override func spec() {
        var sut: MagicCarouselFlowLayoutMock!
        var viewController: CollectionViewControllerMock!
        
        beforeEach {
            sut = MagicCarouselFlowLayoutMock(visibleOffset: 64)
            
            let view = CollectionMock(mockLayout: sut)
            viewController = CollectionViewControllerMock(mockView: view)
            
            UIApplication.shared.keyWindow?.rootViewController = viewController
            
            _ = viewController.view
        }
        
        context("when it is initialized") {
            it("has minimumInteritemSpacing equal to 0") {
                expect(sut.minimumInteritemSpacing).to(equal(16))
            }
            
            it("has minimumInteritemSpacing equal to 0") {
                expect(sut.minimumLineSpacing).to(equal(10))
            }
            
            it("has section header should pin visible bounds") {
                expect(sut.collectionView?.isPagingEnabled).to(beFalse())
            }
            
            it("has built layout properly") {
                self.tester().waitForAnimationsToFinish()
                expect(viewController) == snapshot()
            }
        }
        
        context("on CollectionViewFlowLayout lifecycle") {
            it("layoutAttributesForElements method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.layoutAttributesForElementsWasCalled).to(beTrue())
            }
            
            it("configLayoutAttribute method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.configLayoutAttributeWassCalled).to(beTrue())
            }
        }
    }
}
