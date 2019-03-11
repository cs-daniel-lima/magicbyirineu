//
//  CardRepositoryMock.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 01/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

@testable import magicbyirineu
class CardRepositoryMock: CardRepository {
    
    enum CardRepositoryMockError:Error {
        case couldNotLoad
    }
    
    var isSuccessfull = true
    
    func fetchCards(page:Int?, name:String?, setCode:String?, type:String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
        
        if self.isSuccessfull {
            completion(.success([
                Card(name: "Forest", set: "2ED", setName: "Unlimited Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Land"], foreignNames: nil),
                Card(name: "Kamahl, Pit Fighter", set: "P15A", setName: "15th Anniversary Cards", imageUrl: nil, types: ["Creature"], foreignNames: nil),
                Card(name: "Time Sieve", set: "ARB", setName: "Alara Reborn", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=189649&type=card", types: ["Artifact"], foreignNames: nil),
                Card(name: "Vedalken Ghoul", set: "ARB", setName: "Alara Reborn", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=183010&type=card", types: ["Creature"], foreignNames: nil),
                Card(name: "Naga Oracle", set: "AKH", setName: "Amonkhet", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=426764&type=card", types: ["Creature"], foreignNames: nil),
                ]), 5)
        } else {
            completion(.failure(CardRepositoryMockError.couldNotLoad), nil)
        }
    }
}
