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
        
        let cardRepositoryMock = CardRepositoryMock()
        let cardSetRepositoryMock = CardSetRepositoryMock()
        let typeRepositoryMock = TypeRepositoryMock()
        
        var sut:CardListInteractor!
        
        beforeEach {
            sut = CardListInteractor(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)
        }
        
        context("When it is initialized"){
            it("should have CardSets"){
                expect(sut.sets.count > 0).to(beTrue())
            }
            it("should have Types"){
                expect(sut.types.count > 0).to(beTrue())
            }
        }
        
        context("When it is called fetchCards"){
            it("should have 10 Cards"){
                sut.fetchCards(completion: {_ in })
                expect(sut.cards.count == 10).to(beTrue())
            }
            it("the first card should have the name Forest"){
                expect(sut.cards.first!.name == "Forest").to(beTrue())
            }
        }
        
        context("When it is called fetchCardSet"){
            it("should have 4 Sets"){
                sut.fetchSets()
                expect(sut.sets.count == 4).to(beTrue())
            }
            it("the first Set should have the name Unlimited Edition"){
                expect(sut.sets.first!.name == "Unlimited Edition").to(beTrue())
            }
        }
        
        context("When it is called fetchCards"){
            it("should have 17 types"){
                sut.fetchTypes()
                expect(sut.types.count == 17).to(beTrue())
            }
            it("the last Type should have the name You'll"){
                expect(sut.types.last! == "You’ll").to(beTrue())
            }
        }
        
        afterEach {
            sut!.cleanAll()
        }
    }
}
