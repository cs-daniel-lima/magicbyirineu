//
//  CardListRouter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardListRouter{
    
    var presenter: CardListPresenter!
    
    init() {
        
        let viewController = CardListViewController(title: "Cards")
        let interactor = CardListInteractor(cardRepository: CardAPIClient(),
                                            cardSetRepository: CardSetAPIClient(),
                                            typeRepository: TypeAPIClient())
        self.presenter = CardListPresenter(router:self, interactor:interactor, view:viewController)
        
    }
    
    func goToCardDetail(cards:Array<Card>, selectedCard: Card){
        
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard)
        self.presenter.view.present(router.presenter.view, animated: true, completion: nil)
        
    }
    
}

