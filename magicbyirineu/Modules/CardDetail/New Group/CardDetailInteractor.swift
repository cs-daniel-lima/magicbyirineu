//
//  CardDetailInteractor.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardDetailInteractor{
    
    let cards:Array<Card>
    var selectedCard:Card
    
    init(cards:Array<Card>, selectedCard:Card){
        
        self.cards = cards
        self.selectedCard = selectedCard
        
    }
    
    func changeSelectedCard(index:Int){
        selectedCard = cards[index]
        print(selectedCard)
    }
    
}
