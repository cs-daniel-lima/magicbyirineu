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
    
    var isFirstLoad: Bool = true
    
    var router: CardListRouter
    var interactor: CardListInteractor!
    var view: CardListViewController!
    
    init(router: CardListRouter, interactor: CardListInteractor, view: CardListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.view.screen.collectionView.dataSource = self
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
        
        let numberOfSections = self.interactor.numberOfSets()
        
        if numberOfSections == 0 && isFirstLoad == false {
           self.view.set(status: .empty)
        }else{
           self.view.set(status: .normal)
        }
        isFirstLoad = false
        return numberOfSections

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.interactor.numberOfElementsForSet(setIndex: section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var cell:UICollectionViewCell = UICollectionViewCell()
        
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return cell
        }
        
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
                cardCell.cardTitle.text = ""
                
            }else{
                
                cardCell.backgroundImage.image = UIImage(named: "cartaVerso")
                cardCell.cardTitle.text = card.name
                
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


extension CardListPresenter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return
        }
        
        
        guard let card = object as? Card else {
            Logger.log(in: self, message: "Couldn't cast object to type Card" )
            return
        }
        self.router.goToCardDetail(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let currentSet = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if(indexPath.row == currentSet && !interactor.waitingAPIResponse){
            
            interactor.paginate()
            
        }
        
    }
    
}

extension CardListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get the object from CardSet at index:\(indexPath.section)")
            return CGSize.zero
        }
        
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
            guard let query = self.query else {
                Logger.logError(in: self, message: "Query is nil")
                return
            }
            self.interactor.fetchSearchingCards(cardName: query)
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
