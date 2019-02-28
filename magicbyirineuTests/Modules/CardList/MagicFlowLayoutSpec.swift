//
//  MagicFlowLayoutSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 28/02/2019.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import KIF

@testable import magicbyirineu

class MagicFlowLayoutSpec:QuickSpec{
    
    override func spec() {
        
        var sut:MagicFlowLayoutMock!
        var viewController:CollectionMockViewController!
        
        beforeEach {
            
            sut = MagicFlowLayoutMock()
            
            let view = CollectionMock(mockLayout: sut)
            viewController = CollectionMockViewController(mockView: view)
            
            UIApplication.shared.keyWindow?.rootViewController = viewController
            
            _ = viewController.view
            
        }
        
        
        context("when it is initialized"){
            
            it("minimumInteritemSpacing should be 0"){
                
                expect(sut.minimumInteritemSpacing).to(equal(0))
                
            }
            
            it("minimumLineSpacing should be 16"){
                
                expect(sut.minimumLineSpacing).to(equal(16))
                
            }
            
            it("section header should pin to visible bounds"){
                expect(sut.sectionHeadersPinToVisibleBounds).to(beTrue())
                
            }
            
            it("should view match with snapshot when displayed in a UIViewController") {
                
                self.tester().waitForAnimationsToFinish()
                expect(viewController) == snapshot()
                
            }
            
        }
        
        
        context("on CollectionViewFlowLayout lifecicle"){
            
            it("align method must be called"){
                self.tester().waitForAnimationsToFinish()
                expect(sut.alignWasCalled).to(beTrue())
            }
            
            it("layoutAttributesForItem method must be called"){
                self.tester().waitForAnimationsToFinish()
                expect(sut.layoutAttributesForItemWasCalled).to(beTrue())
            }
            
            it("layoutAttributesForElements method must be called"){
                self.tester().waitForAnimationsToFinish()
                expect(sut.layoutAttributesForElementsWasCalled).to(beTrue())
            }
            
            it("getCollectionWidth method must be called"){
                self.tester().waitForAnimationsToFinish()
                expect(sut.getCollectionWidthWasCalled).to(beTrue())
            }
            
        }
        
        
        
    }
}
