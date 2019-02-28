//
//  CardsCollectionInteractor.swift
//  CollectionWithSubSections
//
//  Created by kaique.magno.santos on 20/02/19.
//  Copyright © 2019 kaique.magno.santos. All rights reserved.
//

import UIKit

protocol CardListInteractorDelegate:class {
    func didLoad()
    func didLoad(error:Error)
}

class CardListInteractor: NSObject {
    
    //MARK: - Properties
    private var cardRepository:CardRepository
    private var cardSetRepository:CardSetRepository
    private var typeRepository:TypeRepository
    
    private var fetchedCards:[Card] = [Card]()
    private var searchedCards:[Card] = [Card]()
    
    private var fetchedCardsPage:Int = 0
    private var searchingCardsPage:Int = 0
    private var pageLastModified:Int = 0
    
    private var isLoaded:Bool {
        return self.sets.count != 0 && self.types.count != 0
    }
    
    private(set) var isSearching:Bool = false
    
    weak var delegate:CardListInteractorDelegate?
    
    private(set) var sets:[CardSet] = [CardSet]()
    private(set) var types:[String] = [String]()
    var cards:[Card] {
        if isSearching {
            return self.searchedCards
        }else{
            return self.fetchedCards
        }
    }
    
    var objectsBySet:[Int:[Any]] = [Int:[Any]]()
    
    //MARK: - NSObject functions
    init(cardRepository:CardRepository, cardSetRepository:CardSetRepository, typeRepository:TypeRepository) {
        self.cardRepository = cardRepository
        self.cardSetRepository = cardSetRepository
        self.typeRepository = typeRepository
        
        super.init()
        
        self.fetchSets()
        self.fetchTypes()
    }
    
    
    //MARK: - Functions
    //MARK: Private
    private func cleanSearchData() {
        self.searchingCardsPage = 0
        self.pageLastModified = 0
        self.searchedCards = [Card]()
    }
    
    private func cleanCardsData() {
        self.pageLastModified = 1
        self.fetchedCardsPage = 1
        self.fetchedCards = [Card]()
    }
    
    private func cleanAll() {
        self.cleanSearchData()
        self.cleanCardsData()
    }
    
    //MARK: Public
    func fetchSets(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.cardSetRepository.getAll { (result) in
            switch result {
            case .success(let sets):
                self.sets = sets
                self.sets.sort(by: { (before, after) -> Bool in
                    return before.releaseDate < after.releaseDate
                })
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetchTypes(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.typeRepository.getAll { (result) in
            switch result {
            case .success(let types):
                self.types = types
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetchCards(completion: ((_ success:Bool) -> Void)? = nil ) {
        if self.isLoaded {
            self.fetchedCardsPage += 1
            
            self.cardRepository.getAll(page: self.fetchedCardsPage, name: nil, setCode: nil, type: nil, completion: { (result) in
                
                switch result {
                case .success(let cards):
                    self.fetchedCards.append(contentsOf: cards)
                    self.objectsBySet = self.sequenceOfCategoriesAndCardsBySection(self.fetchedCards)
                    self.delegate?.didLoad()
                    
                case .failure(let error):
                    self.delegate?.didLoad(error: error)
                    
                }
            })
        }else if self.sets.count == 0 {
            self.fetchSets { (success) in
                switch success {
                case true:
                    self.fetchCards(completion: completion)
                case false:
                    completion?(false)
                }
            }
        }else if self.types.count == 0 {
            self.fetchTypes { (success) in
                switch success {
                case true:
                    self.fetchCards(completion: completion)
                case false:
                    completion?(false)
                }
            }
        }
        
    }
    
    func fetchSearchingCards(cardName:String) {
        self.searchingCardsPage += 1
        
        self.cardRepository.getAll(page: self.searchingCardsPage, name:cardName , setCode: nil, type: nil) { (result) in
            switch result {
            case .success(let cards):
                self.searchedCards.append(contentsOf: cards)
                self.objectsBySet = self.sequenceOfCategoriesAndCardsBySection(self.searchedCards)
                self.delegate?.didLoad()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    //MARK: Public
    func cancelSearch() {
        self.cleanSearchData()
    }
    
    //MARK Card
    func cards(_ cards:[Card], from category:String, in set:CardSet) -> [Card] {
        let someCards = cards.filter { (card) -> Bool in
            return (card.set == set.code && card.types.contains(category))
        }
        
        return someCards.sorted { (before, after) -> Bool in
            return before.name.compare(after.name) == .orderedAscending
        }
    }
    
    func cardsByCategories(_ cards:[Card], in set:CardSet) -> [String:[Card]] {
        var cardsByCategories:[String:[Card]] = [String:[Card]]()
        
        for category in types {
            cardsByCategories[category] = self.cards(cards, from: category, in: set)
        }
        
        return cardsByCategories
    }
    
    func cardsByCategories(_ cards:[Card], in section:Int) -> [String:[Card]] {
        let set = self.sets[section]
        
        return self.cardsByCategories(cards, in: set)
    }
    
    
    func sequenceOfCategoriesAndCards(_ cards:[Card], by set:CardSet) -> [Any] {
        let cardsByCategories = self.cardsByCategories(cards, in: set)
        
        var arraySequence = [Any]()
        
        for object in cardsByCategories {
            if object.value.count > 0 {
                arraySequence.append(object.key)
                arraySequence.append(contentsOf: object.value)
            }
        }
        
        return arraySequence
    }
    
    func sequenceOfCategoriesAndCards(_ cards:[Card], by section:Int) -> [Any] {
        let set = self.sets[section]
        
        return self.sequenceOfCategoriesAndCards(cards, by: set)
    }
    
    func sequenceOfCategoriesAndCardsBySection(_ cards:[Card]) -> [Int:[Any]] {
        var objects:[Int:[Any]] = [Int:[Any]]()
        
        for i in 0..<self.sets.count {
            let set = self.sets[i]
            let objectsArray = self.sequenceOfCategoriesAndCards(cards, by: set)
            if objectsArray.count > 0 {
                objects[i] = objectsArray
            }
        }
        
        return objects
    }
}
