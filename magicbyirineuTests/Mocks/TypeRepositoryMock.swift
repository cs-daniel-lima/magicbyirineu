//
//  TypeRepositoryMock.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 01/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

@testable import magicbyirineu
class TypeRepositoryMock:TypeRepository {
    
    enum TypeRepositoryMockError:Error {
        case couldNotLoad
    }
    
    var isSuccessful = true
    
    func getAll(completion: @escaping (Result<[String]>) -> Void) {
        if self.isSuccessful {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            completion(.success([
                "Artifact",
                "Conspiracy",
                "Creature",
                "Enchantment",
                "Hero",
                "instant",
                "Instant",
                "Land",
                "Phenomenon",
                "Plane",
                "Planeswalker",
                "Scheme",
                "Sorcery",
                "Summon",
                "Tribal",
                "Vanguard",
                "You’ll"
                ]))
        }else{
            completion(.failure(TypeRepositoryMockError.couldNotLoad))
        }
    }
}


