//
//  CardSet.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

struct CardSet: Decodable {
    let code:String
    let name:String
    let type:String
    let releaseDate:Date
}

extension CardSet: Hashable {}
