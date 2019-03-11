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
            let interactor = CardListInteractor(cardRepository: CardRepositoryMock(), cardSetRepository: CardSetRepositoryMock(), typeRepository: TypeRepositoryMock())
            sut.presenter = CardListPresenterMock(router: CardListRouter(), interactor: interactor, view: sut)
            UIApplication.shared.keyWindow?.rootViewController = sut
        }
        
        context("when it is initialized"){
            it("should view match with snapshot"){
                self.tester().waitForAnimationsToFinish()
                expect(sut) == snapshot()
            }
            
            it("isFirstLoad should begin as true", closure: {
                expect(sut.presenter.isFirstLoad).to(beTrue())
            })
            
            it("router should not be nil", closure: {
                expect(sut.presenter.router).notTo(beNil())
            })
            
            it("interactor should not be nil", closure: {
                expect(sut.presenter.interactor).notTo(beNil())
            })
        }
        
        context("on cardListPresenter life cycle") {

            it("shoud call numberOfSections", closure: {
                self.tester().waitForAnimationsToFinish()
                expect((sut.presenter as! CardListPresenterMock).wasNumberOfSectionCalled).to(beTrue())
            })
            
            it("should call numberOfSections", closure: {
                self.tester().waitForAnimationsToFinish()
                expect((sut.presenter as! CardListPresenterMock).wasCellForItemAtCalled).to(beTrue())
            })
            
        }
       
    }
}
