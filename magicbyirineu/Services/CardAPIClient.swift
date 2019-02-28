//
//  MarvelAPIClient.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardAPIClient {
    
    var apiManager:APIManager
    
    init() {
        self.apiManager = APIManager()
    }
}

extension CardAPIClient: CardRepository {
    func getAll(page: Int?, name: String?, setCode: String?, type: String?, completion: @escaping (Result<[Card]>) -> Void) {
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
