//
//  CardListInteractorSpec.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 01/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class CardListInteractorSpec:QuickSpec{
    
    override func spec() {
        
        var cardRepositoryMock:CardRepositoryMock!
        var cardSetRepositoryMock:CardSetRepositoryMock!
        var typeRepositoryMock:TypeRepositoryMock!
        
        var sut:CardListInteractor!
        
        beforeEach {
            cardRepositoryMock = CardRepositoryMock()
            cardSetRepositoryMock = CardSetRepositoryMock()
            typeRepositoryMock = TypeRepositoryMock()
            sut = CardListInteractor(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)
        }
        
        context("when it is initialized"){
            it("has CardSets count greater than zero"){
                sut.fetchCards()
                expect(sut.numberOfSets() > 0).to(beTrue())
            }
        }
        
        context("when it is called fetchCards"){
            it("organizer first element should not be nil"){
//                sut.fetchCards()
                expect(sut.fetchedCardOrganizer.getElement(setIndex: 0, elementIndex: 0)).toNot(beNil())
            }
        }
        
        context("when it is called fetchCards"){
            it("the first set should have 12 Elements"){
//                sut.fetchCards()
//                print(sut.fetchedCardOrganizer.decks[0].getElements().count)
//                expect(sut.fetchedCardOrganizer.decks[0].getElements().count).to(be(12))
            }
            it("has the first card with name Forest"){
                expect((sut.fetchedCardOrganizer.getElement(setIndex: 0, elementIndex: 1) as! Card).name).to(be("Forest"))
            }
        }
        
        context("when it is called fetchCardSet"){
            it("should have 4 Sets"){
//                sut.fetchCards()
                expect(sut.numberOfSets() == 4).to(beTrue())
            }
            it("the first Set should have the name Unlimited Edition"){
                expect(sut.set(of: 0).name == "Unlimited Edition").to(beTrue())
            }
        }
    }
}
