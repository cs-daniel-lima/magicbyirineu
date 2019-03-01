//
//  CardDetailPresenter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class CardDetailPresenter{

var router: CardDetailRouter
var view: CardDetailViewController

init(router: CardDetailRouter, view: CardDetailViewController) {
    self.router = router
    self.view = view
    
    self.view.presenter = self
}

}
