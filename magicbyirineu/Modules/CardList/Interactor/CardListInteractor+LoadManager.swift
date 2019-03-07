//
//  CardListInteractor+LoadManager.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

extension CardListInteractor:LoadManagerDelegate{
    
    
    func loaded(cards: [Card], forType type: String, andSet set: CardSet) {
        
        if cards.count > 0{
            
            cardOrganizer.append(cards: cards, set: set, type: type, setIndex: currentSetPagination)
            delegate?.didLoad()
            waitingAPIResponse = false
            
        }else{
            waitingAPIResponse = true
            paginate()
        }
        
    }
    
    func requestApiCardsDataFor(set: CardSet?, andType type: String?, withPage page: Int) {
        
        if let setToload = set, let typeToLoad = type{
            
            self.cardRepository.fetchCards(page: page, name: nil, setCode: setToload.code, type: typeToLoad, orderParameter: CardOrder.name, completion: { (result, totalCount) in
                switch result {
                case .success(let cardsResponse):
                    
                    if let total = totalCount{
                        self.loadManager.appendCards(cardsResponse, totalExpected: total)
                    }
                    
                case .failure(let error):
                    self.delegate?.didLoad(error: error)
                    
                }
            })
            
        }
        
    }
    
    
    
    
    
}
