//
//  ResponseError.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

struct ResponseError: Decodable {
    
    let statusCode:Int
    let statusMessage:String?
    
    public init (statusCode:Int = 0, statusMessage:String? = nil) {
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
}
