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
var interactor: CardDetailInteractor
var view: CardDetailViewController

init(router: CardDetailRouter, interactor: CardDetailInteractor, view: CardDetailViewController) {
    self.router = router
    self.interactor = interactor
    self.view = view
    
    self.view.presenter = self
}

}
