//
//  CardDetailPresenter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation
import UIKit

class CardDetailPresenter:NSObject{
    
    var router: CardDetailRouter?
    let view: CardDetailViewController
    let interactor:CardDetailInteractor
    
    var pageSize:CGSize{
        if let layout = self.view.screen.collectionView.collectionViewLayout as? MagicCarouselFlowLayout{
            return CGSize(width: layout.minimumLineSpacing, height: layout.itemSize.height)
        }else{
            return CGSize.zero
        }
    }
    
    init(interactor:CardDetailInteractor, view: CardDetailViewController) {
        self.view = view
        self.interactor = interactor
        
        super.init()
        
        self.view.presenter = self
        
        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self
        
        setup()
        
    }
    
    func setup(){
        self.view.screen.collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
    }
    
    public func collectionViewDidScroolToItemAt(indexPath: IndexPath){
        interactor.changeSelectedCard(index: indexPath.row)
    }
    
}

extension CardDetailPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell{
            
            
            cell.setupCell(cardHeight: 264)
            
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
    }
    
}

extension CardDetailPresenter: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let centerPosition = CGPoint(x: self.view.screen.bounds.midX, y: self.view.screen.bounds.midY)
        let relatedPositionInCollectionView = self.view.screen.convert(centerPosition, to: self.view.screen.collectionView)
        
        if let indexPath = self.view.screen.collectionView.indexPathForItem(at: relatedPositionInCollectionView) {
            collectionViewDidScroolToItemAt(indexPath: indexPath)
        }
        
    }
    
}
