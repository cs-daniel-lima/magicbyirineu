//
//  CardSetAPIClient.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardSetAPIClient {
    
    var apiManager:APIManager
    
    init() {
        self.apiManager = APIManager()
    }
}

extension CardSetAPIClient: CardSetRepository {
    func getAll(completion: @escaping (Result<[CardSet]>) -> Void) {
        let endpoint = EndpointSets()
        
        self.apiManager.fetch(endpoint) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.sets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
