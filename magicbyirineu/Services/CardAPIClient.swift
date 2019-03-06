//
//  MarvelAPIClient.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardAPIClient {
    
    let apiManager:APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension CardAPIClient: CardRepository {
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, completion: @escaping (Result<[Card]>) -> Void) {
        let endpoint = EndpointCards(page: page, name:name, setCode:setCode, type:type)
        
        self.apiManager.fetch(endpoint) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.cards))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
