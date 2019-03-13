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
    let set: String?
    let type: String?
    let orderBy:String?
    
    init(page: Int? = nil, name: String? = nil, setCode: String? = nil, type: String? = nil, orderParameter: CardOrder? = nil) {
        self.page = page
        self.name = name
        self.set = setCode
        self.type = type
        self.orderBy = orderParameter?.rawValue
    }
}
