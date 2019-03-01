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
    
    func goToCardDetail(card: Card){
        
        let router = CardDetailRouter()
        
        if let vc = router.presenter.view as? CardDetailViewController {
            vc.card = card
            self.presenter.view.present(vc, animated: true, completion: nil)
        }else{
            Logger.logError(in: self, message: "Could not present CardDetailViewController")
        }
        
        
    }
    
}

