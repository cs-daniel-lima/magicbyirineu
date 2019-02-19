//
//  URLQueryEncoder.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

enum URLQueryEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        let parametersString = parameters.map({ (value) -> String in
            return "\(value.key)=\(value.value)"
        })
        let parametersSequence = parametersString.joined(separator: "&")
        let parametersEncoded = parametersSequence.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return parametersEncoded
    }
}
