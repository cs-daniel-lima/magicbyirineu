//
//  FavoritesInteractor.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 15/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

class FavoritesInteractor {
    
    let sets =  [CardSet]()
    let types =  [String]()
    
    var dbManager:DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        
        dbManager = databaseManager
        
    }
    
}
