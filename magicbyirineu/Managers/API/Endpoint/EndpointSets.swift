//
//  EndpointSets.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

final class EndpointSets: Endpoint {
    typealias Response = ResponseSets
    
    var endpoint: String {
        return "sets"
    }
    
    let name: String?
    
    init(name: String? = nil) {
        self.name = name
    }
}
