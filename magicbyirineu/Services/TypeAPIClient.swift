//
//  TypeAPIClient.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class TypeAPIClient {
    
    let apiManager:APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension TypeAPIClient: TypeRepository {
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void) {
        let endpoint = EndpointTypes()
        
        self.apiManager.fetch(endpoint) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.types))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
