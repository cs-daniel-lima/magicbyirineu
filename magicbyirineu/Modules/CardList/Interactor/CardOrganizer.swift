//
//  CardOrganizer.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

struct CardDeck {
    
    let identification:CardSet
    private var elements:Array<Any>
    
    init(set:CardSet){
        identification = set
        elements = Array()
    }
    
    mutating func add(type:String){
        elements.append(type)
    }
    
    mutating func add(card:Card){
        elements.append(card)
    }
    
    mutating func add(cards:Array<Card>){
        elements.append(contentsOf: cards)
    }
    
    func getElements()->Array<Any>{
        return elements
    }
    
    func getCards()->Array<Card>{
        
        guard let cards = elements.filter({$0 is Card}) as? Array<Card> else{
            return []
        }
        
        return cards
        
    }
    
    func getElement(at index:Int)->Any?{
        if(elements.indices.contains(index)){
            return elements[index]
        }else{
            return nil
        }
    }
    
}

class CardOrganizer {
    
    var decks:Array<CardDeck> = Array()
    
    func append(cards:[Card], set:CardSet, type:String, setIndex:Int){
        if decks.indices.contains(setIndex){
            decks[setIndex].add(type: type)
            decks[setIndex].add(cards: cards)
        }else{
            var deck = CardDeck(set: set)
            deck.add(type: type)
            deck.add(cards: cards)
            decks.append(deck)
        }
    }
    
    func getElement(setIndex:Int, elementIndex:Int)->Any?{
        if decks.indices.contains(setIndex){
            return decks[setIndex].getElement(at: elementIndex)
        }else{
            return nil
        }
    }
    
    func getAllCards()->Array<Card>{
        
        var allCards:Array<Card> = Array()
        
        for deck in decks{
            allCards.append(contentsOf: deck.getCards())
        }
        
        return allCards
    }
    
}
