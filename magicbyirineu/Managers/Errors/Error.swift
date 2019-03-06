//
//  File.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

extension APIManager {
    enum APIError: Error {
        case encoding
        case decoding
        case server(message: String)
    }
}


