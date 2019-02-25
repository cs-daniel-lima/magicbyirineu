//
//  FavoritesPresenter+UISearchBarDelegate.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

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
