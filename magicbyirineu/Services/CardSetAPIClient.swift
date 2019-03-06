//
//  CardSetAPIClient.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardSetAPIClient {
    
    let apiManager:APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension CardSetAPIClient: CardSetRepository {
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void) {
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
