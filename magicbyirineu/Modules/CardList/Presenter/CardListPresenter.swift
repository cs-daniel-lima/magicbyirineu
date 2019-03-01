//
//  CardListPresenter.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import Kingfisher

class CardListPresenter:NSObject{
    
    // MARK: Private
    private var query:String?
    
    var router: CardListRouter
    var interactor: CardListInteractor!
    var view: CardListViewController!
    
    init(router: CardListRouter, interactor: CardListInteractor, view: CardListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.prefetchDataSource = self
        self.view.screen.collectionView.delegate = self
        self.view.screen.searchBar.delegate = self
        
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
        let keys = self.interactor.objectsBySet.keys.map { (set) -> CardSet in
            return set
        }
        let set = keys[section]
        
        guard let objectList = self.interactor.objectsBySet[set] else {
            Logger.logError(in: self, message: "Could not get objectList in CardSet: \(set)")
            return 0
        }
        
        return objectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell = UICollectionViewCell()
        
        let keys = self.interactor.objectsBySet.keys.map { (set) -> CardSet in
            return set
        }
        let set = keys[indexPath.section]
        let object = self.interactor.objectsBySet[set]![indexPath.row]
        
        
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
            
            cardCell.backgroundImage.image = nil
            
            cardCell.setupCell(cardHeight: (118 / 320) * collectionView.frame.size.width)
            
            if let imageURL = card.imageUrl {
                
                let url = URL(string: imageURL)
                cardCell.backgroundImage.kf.setImage(with: url)
                
            }
            
            cell = cardCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SetCollectionReusableView", for: indexPath) as? SetCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        cell.label.text = self.interactor.sets[indexPath.section].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cardCell = cell as? CardCollectionViewCell {
            cardCell.backgroundImage.image = nil
        }
    }
    
}

extension CardListPresenter: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let cardsCount = self.interactor.cards.count
        if Double(cardsCount) * 0.8 < Double(indexPaths.first?.row ?? 50) {
            if self.interactor.isSearching {
                self.interactor.fetchSearchingCards(cardName: self.query!)
            }else{
                self.interactor.fetchCards() {_ in}
            }
        }
    }
}

extension CardListPresenter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = self.interactor.objectsBySet[indexPath.section]![indexPath.row]
        guard let card = object as? Card else {
            Logger.log(in: self, message: "Couldn't cast object to type Card" )
            return
        }
        self.router.goToCardDetail(card: card)
    }
}

extension CardListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keys = self.interactor.objectsBySet.keys.map { (set) -> CardSet in
            return set
        }
        let set = keys[indexPath.section]
        
        guard let objectList = self.interactor.objectsBySet[set] else {
            Logger.logError(in: self, message: "Could not get the objectList from CardSet:\(set)")
            return CGSize.zero
        }
        
        let object = objectList[indexPath.row]
        
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

extension CardListPresenter: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.query = nil
        self.view.screen.collectionView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            self.query = text
            self.interactor.fetchSearchingCards(cardName: self.query!)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == nil || searchBar.text?.isEmpty ?? false {
            self.interactor.cancelSearch()
            self.view.screen.collectionView.reloadData()
        }
    }
    
}
