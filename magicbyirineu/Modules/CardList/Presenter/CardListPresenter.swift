//
//  CardListPresenter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SDWebImage

class CardListPresenter:NSObject{
    
    var router: CardListRouter!
    var interactor: CardListInteractor!
    var view: CardListViewController!
    
    init(router: CardListRouter, interactor: CardListInteractor, view: CardListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self
        
        
        self.interactor.delegate = self
        
        self.setup()
    }
    
    func setup() {
        self.view.screen.backgroundColor = .magenta
        self.view.screen.collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        self.view.screen.collectionView.register(SubSectionCollectionViewCell.self, forCellWithReuseIdentifier: "SubSectionCollectionViewCell")
        self.view.screen.collectionView.register(SetCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SetCollectionReusableView")
    }
    
}

extension CardListPresenter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.interactor.objectsBySet.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.sequenceOfCategoriesAndCards(by: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell = UICollectionViewCell()
        
        let object = self.interactor.object(by: indexPath)
        
        if let category = object as? String {
            guard let subsectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubSectionCollectionViewCell", for: indexPath) as? SubSectionCollectionViewCell else {
                Logger.logError(in: self, message: "Could not cast to SubSectionCollectionViewCell")
                return UICollectionViewCell()
            }
            
            subsectionCell.label.text = category.capitalized
            
            cell = subsectionCell
            
        } else if let card = object as? Card {
            guard let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
                Logger.logError(in: self, message: "Could not cast to CardCollectionViewCell")
                return UICollectionViewCell()
            }
            
            cardCell.setupCell(cardHeight: (118 / 320) * collectionView.frame.size.width)
            
            if let imageURL = card.imageUrl {
                cardCell.backgroundImage.sd_setImage(with: URL(string: imageURL), completed: nil)
            }
            
            cell = cardCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SetCollectionReusableView", for: indexPath) as? SetCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        let x = self.interactor.objectsBySet.keys
        let y = x.compactMap { (cardSet) -> CardSet in
            return cardSet
        }
        
        cell.label.text = y[indexPath.section].name
        
        return cell
    }
}


extension CardListPresenter: UICollectionViewDelegate {
    
}

extension CardListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let object = self.interactor.object(by: indexPath)
        
        if object is String {
            return CGSize(width: UIScreen.main.bounds.width, height: 16)
        }else{
            return CGSize(width: collectionView.frame.size.width/3, height: (118 / 320) * collectionView.frame.size.width)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}

extension CardListPresenter: CardListInteractorDelegate {
    func didLoad(error: Error) {
        
    }
    
    func didLoad() {
        DispatchQueue.main.async {
            self.view.screen.collectionView.reloadData()
        }
    }
}
