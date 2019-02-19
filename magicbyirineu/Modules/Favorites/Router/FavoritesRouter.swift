//
//  FavoritesRouter.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 19/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class FavoritesRouter {
    
    var presenter: FavoritesPresenter!
    
    init(){
        
        let viewController = FavoritesViewController()
        let interactor = FavoritesInteractor()
        
        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
        
    }
    
}
