//
//  EndpointCategories.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

final class EndpointTypes: Endpoint {
    typealias Response = ResponseTypes
    
    var endpoint: String {
        return "types"
    }
}
