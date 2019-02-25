//
//  CategoriesCollectionViewDataSource.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class CategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    init(collectionView: UICollectionView) {
        super.init()
        self.setupCollectionView(collectionView: collectionView)
    }
    
    private func setupCollectionView(collectionView: UICollectionView){
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cardCollectionViewCell")
        print("test")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 3..<20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else{
            Logger.logError(in: self, message: "Could not cast cell as CardCollectionView")
            return UICollectionViewCell()
        }
        cell.setupCell(cardHeight: (118 / 320) * collectionView.frame.size.width)
        return cell
    }
    
}


