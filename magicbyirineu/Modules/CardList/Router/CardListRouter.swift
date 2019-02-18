//
//  CardListRouter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardListRouter:NSObject {
    
    var presenter: CardListPresenter!
    
    override init() {
        super.init()
        
        let viewController = CardListViewController()
        let interactor = CardListInteractor()
    
        self.presenter = CardListPresenter(router:self, interactor:interactor, view:viewController)
    }
    
}
