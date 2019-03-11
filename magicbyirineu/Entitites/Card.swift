//
//  Card.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

struct Card: Decodable, Equatable {
    
    let name:String
    let set:String
    let setName:String
    let imageUrl:String?
    let types:[String]
    let foreignNames: [ForeignNames]?
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        
        if(lhs.name != rhs.name){
            return false
        }
        if(lhs.set != rhs.set){
            return false
        }
        if(lhs.setName != rhs.setName){
            return false
        }
        if(lhs.imageUrl != rhs.imageUrl){
            return false
        }
        if(lhs.name != rhs.name){
            return false
        }
        if(lhs.foreignNames?.count != rhs.foreignNames?.count){
            return false
        }
        
        return true
    }
    
}
