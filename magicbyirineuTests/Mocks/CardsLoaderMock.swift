//
//  CardsLoaderMock.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 13/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

@testable import magicbyirineu

final class CardsLoaderMock:CardsLoader {
    
    var isFetchedSuccess = true
    
    override func fetchCards(with name: String?) {
        var cards = [
            Card(name: "Card A", set: "SetCode A", setName: "Set A", imageUrl: "imageUrl A", types: ["Type A"]),
            Card(name: "Card B", set: "SetCode A", setName: "Set A", imageUrl: "imageUrl B", types: ["Type A"]),
            Card(name: "Card C", set: "SetCode A", setName: "Set A", imageUrl: "imageUrl C", types: ["Type A"])
        ]
        
        if let name = name {
            cards = cards.filter({ (card) -> Bool in
                return card.name.lowercased().contains(name.lowercased())
            })
        }
        
        
        if self.isFetchedSuccess {
            self.delegate?.loaded(
                cards: cards,
                forType: "A",
                andSet: CardSet(code: "SetCode A", name: "Set A", type: "Type A", releaseDate: Date()),
                from: self
            )
        }else{
            self.delegate?.loaded(error: ErrorMock())
        }
    }
}


