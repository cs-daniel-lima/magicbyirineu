//
//  EndpointCards.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

final class EndpointCards: Endpoint {
    typealias Response = ResponseCards
    
    var endpoint: String {
        return "cards"
    }
    
    let page: Int?
    let name: String?
    
    init(page: Int? = nil, name: String? = nil) {
        self.page = page
        self.name = name
    }
}
