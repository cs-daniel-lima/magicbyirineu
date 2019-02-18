//
//  CardListPresenter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class CardListPresenter{
    
    var router: CardListRouter
    var interactor: CardListInteractor
    var view: CardListViewController
    
    init(router: CardListRouter, interactor: CardListInteractor, view: CardListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        self.view.presenter = self
    }
    
}
