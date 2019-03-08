//
//  CardDetailRouter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardDetailRouter{
    
    let presenter: CardDetailPresenter
    
    init(cards:Array<Card>, selectedCard:Card) {
        
        let viewController = CardDetailViewController()
        let interactor = CardDetailInteractor(cards: cards, selectedCard: selectedCard)
        
        self.presenter = CardDetailPresenter(interactor: interactor, view:viewController)
        
        setupPresenter()
        
    }
    
    func setupPresenter(){
        presenter.router = self
    }
    
}
