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
        
        
        let cardRepository = CardAPIClient()
        let cardSetRepository = CardSetAPIClient()
        let typeRepository = TypeAPIClient()
        
        let fetchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        let searchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        
        let fetchOrganizer = CardOrganizer()
        let searchOrganizer = CardOrganizer()
        
        let interactor = CardListInteractor(fetchLoader: fetchLoader, searchLoad: searchLoader, fetchCardOrganizer: fetchOrganizer, searchCardOrganizer: searchOrganizer)
        self.presenter = CardListPresenter(router:self, interactor:interactor, view:viewController)
        
    }
    
    func goToCardDetail(card: Card){
        
        let router = CardDetailRouter()
        
        router.presenter.view.card = card
        self.presenter.view.present(router.presenter.view, animated: true, completion: nil)
        
        
    }
    
}

