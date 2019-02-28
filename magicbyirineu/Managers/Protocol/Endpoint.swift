//
//  Endpoint.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

protocol Endpoint: Encodable {
    associatedtype Response: Decodable
    
    var endpoint: String { get }
}
