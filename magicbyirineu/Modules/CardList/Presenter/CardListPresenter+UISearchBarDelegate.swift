//
//  CardListPresenter+UISearchBarDelegate.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

extension CardListPresenter:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        /*
        if let searchText = searchBar.text{
            
            print("Buscar: ", searchText)
            
            let manager = APIManager()
            let request = RequestCards(page: 0, name: searchText)
            
            manager.fetch(request) { (result) in
                
                //print(result)
                
            }
        }
        */
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchElement = searchBar as? MagicSearchBar{
            searchElement.cancelUserInteraction()
        }
        
    }
    
}
