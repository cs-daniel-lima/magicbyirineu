//
//  FavoritesPresenter.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 19/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation
import UIKit

class FavoritesPresenter:NSObject{
    
    var router: FavoritesRouter
    var interactor: FavoritesInteractor
    var view: FavoritesViewController
    
    init(router: FavoritesRouter, interactor: FavoritesInteractor, view: FavoritesViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.view.presenter = self
    }
    
}


extension FavoritesPresenter:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text{
            
            print("Buscar: ", searchText)
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchElement = searchBar as? MagicSearchBar{
            searchElement.cancelUserInteraction()
        }
        
    }
    
}
