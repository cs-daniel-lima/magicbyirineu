//
//  CardDeck.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 11/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

///Mantem as cartas organizadas
struct CardDeck {
    
    let identification:CardSet
    private var elements:Array<Any>
    
    init(set:CardSet){
        identification = set
        elements = Array()
    }
    
    mutating func add(type:String) {
        
        if(!elements.contains(string: type)){
            elements.append(type)
        }
        
        
    }
    
    mutating func add(card:Card) {
            elements.append(card)
    }
    
    mutating func add(cards:Array<Card>) {
        elements.append(contentsOf: cards)
    }
    
    func getElements() -> Array<Any> {
        return elements
    }
    
    func getElement(at index:Int) -> Any? {
        if(elements.indices.contains(index)){
            return elements[index]
        }else{
            return nil
        }
    }
}
