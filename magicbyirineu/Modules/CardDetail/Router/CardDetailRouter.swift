//
//  CardDetailRouter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardDetailRouter{

var presenter: CardDetailPresenter!

init() {
    
    let viewController = CardDetailViewController()
    
    self.presenter = CardDetailPresenter(router:self, view:viewController)
}
    
}

