//
//  RealmCards.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 12/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class RealmCards{
    
    
    
    
}

extension RealmCards:CardRepository{
    
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
        
    }
    
}
