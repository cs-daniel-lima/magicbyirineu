//
//  Card.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

struct Card: Decodable {
    let name:String
    let set:String
    let setName:String
    let imageUrl:String?
    let types:[String]
    let foreignNames: [ForeignNames]?
}
