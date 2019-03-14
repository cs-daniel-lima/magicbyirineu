//
//  Array+Any.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 14/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == Any{
    
    func contains(string:String)->Bool{
        
        if let elements:Array<String> = self.filter({ $0 is String}) as? Array<String>{
        
            if elements.contains(string){
                return true
            }else{
                return false
            }
            
            
        }else{
            
            return false
        }
        
        
    }
    
    func contains(card:Card)->Bool{
        
        if let elements:Array<Card> = self.filter({ $0 is Card}) as? Array<Card>{
            
            let matchingCards = elements.filter{ $0.id == card.id }
            
            if(matchingCards.count > 0){
                return true
            }else{
                return false
            }
            
            
        }else{
            
            return false
        }
        
    }
    
    mutating func appendCards(_ cards: [Card]){
        
        for c in cards{
            
            if (!contains(card: c)){
                self.append(c)
            }
            
        }
        
    }
    
}
