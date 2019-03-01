//
//  CardSetRepositoryMock.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 01/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

@testable import magicbyirineu
class CardSetRepositoryMock:CardSetRepository {
    
    enum CardSetRepositoryMockError:Error {
        case couldNotLoad
    }
    
    var isSuccessful = true
    
    func getAll(completion: @escaping (Result<[CardSet]>) -> Void) {
        if self.isSuccessful {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            completion(.success([
                CardSet(code: "2ED", name: "Unlimited Edition", type: "core", releaseDate: dateFormatter.date(from: "1993-12-01")!),
                CardSet(code: "3ED", name: "Revised Edition", type: "core", releaseDate: dateFormatter.date(from: "1994-04-01")!),
                CardSet(code: "10E", name: "Tenth Edition", type: "core", releaseDate: dateFormatter.date(from: "2007-07-13")!),
                CardSet(code: "5DN", name: "Fourth Edition", type: "core", releaseDate: dateFormatter.date(from: "1995-04-01")!),
                ]))
        }else{
            completion(.failure(CardSetRepositoryMockError.couldNotLoad))
        }
    }
}
