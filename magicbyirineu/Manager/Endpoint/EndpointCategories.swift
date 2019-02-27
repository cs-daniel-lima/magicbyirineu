//
//  EndpointCategories.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

final class EndpointCategories: Endpoint {
    typealias Response = ResponseCategories
    
    var endpoint: String {
        return "types"
    }
}
