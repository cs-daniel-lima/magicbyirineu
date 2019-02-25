//
//  RequestCategories.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

final class RequestCategories: APIRequest {
    typealias Response = ResponseCategories
    
    var endpoint: String {
        return "types"
    }
}
