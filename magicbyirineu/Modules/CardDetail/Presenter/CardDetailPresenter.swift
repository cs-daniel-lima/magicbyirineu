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
    
}

extension CardDetailPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
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
    
    /*
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }*/
    
}

extension CardDetailPresenter: UICollectionViewDelegateFlowLayout {
    
    
    
}
