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
    
    var objectsBySet:[CardSet:[Any]] = [CardSet:[Any]]()
    
    //MARK: - NSObject functions
    init(cardRepository:CardRepository, cardSetRepository:CardSetRepository, typeRepository:TypeRepository) {
        self.cardRepository = cardRepository
        self.cardSetRepository = cardSetRepository
        self.typeRepository = typeRepository
        
        super.init()
        
        self.fetchTypes { (result) in  
            self.fetchSets { (result) in
                self.fetchCards() {_ in }
            }
        }
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
    
    private func cleanCardData() {
        self.cleanSearchData()
        self.cleanCardsData()
    }
    
    func cleanAll() {
        self.sets = [CardSet]()
        self.types = [String]()
        self.cleanCardData()
    }
    
    //MARK: Public
    func fetchSets(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.cardSetRepository.fetchCardSets { (result) in
            switch result {
            case .success(let sets):
                self.sets = sets
                self.sets.sort(by: { (before, after) -> Bool in
                    return before.releaseDate < after.releaseDate
                })
                completion?(true)
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
                completion?(false)
            }
        }
    }
    
    func fetchTypes(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.typeRepository.fetchTypes { (result) in
            switch result {
            case .success(let types):
                self.types = types
                completion?(true)
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
                completion?(false)
            }
            
        }
    }
    
    func fetchCards(completion: @escaping (_ success:Bool) -> Void) {
        if self.isLoaded {
            
            self.cardRepository.fetchCards(page: self.fetchedCardsPage, name: nil, setCode: nil, type: nil, completion: { (result) in
                switch result {
                case .success(let cardsResponse):
                    self.fetchedCardsPage += 1
                    self.fetchedCards.append(contentsOf: cardsResponse)
                    self.objectsBySet = self.sequenceOfTypesAndCardsBySection(self.cards)
                    completion(true)
                    
                case .failure(let error):
                    self.delegate?.didLoad(error: error)
                    completion(false)
                    
                }
                self.delegate?.didLoad()
            })
        }else if self.sets.count == 0 {
            self.fetchSets { (success) in
                switch success {
                case true:
                    self.fetchCards(completion: completion)
                case false:
                    completion(true)
                }
            }
        }else if self.types.count == 0 {
            self.fetchTypes { (success) in
                switch success {
                case true:
                    self.fetchCards(completion: completion)
                case false:
                    completion(false)
                }
            }
        }
    }
    
    func fetchSearchingCards(cardName:String) {
        self.searchingCardsPage += 1
        
        self.cardRepository.fetchCards(page: self.searchingCardsPage, name:cardName , setCode: nil, type: nil) { (result) in
            switch result {
            case .success(let cards):
                self.searchedCards.append(contentsOf: cards)
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
    func cards(_ cards:[Card], from type:String, in set:CardSet) -> [Card] {
        let someCards = cards.filter { (card) -> Bool in
            return (card.set == set.code && card.types.contains(type))
        }
        
        return someCards.sorted { (before, after) -> Bool in
            return before.name.compare(after.name) == .orderedAscending
        }
    }
    
    func cardsByType(_ cards:[Card], in set:CardSet) -> [String:[Card]] {
        var cardsByType:[String:[Card]] = [String:[Card]]()
        
        for type in types {
            cardsByType[type] = self.cards(cards, from: type, in: set)
        }
        
        return cardsByType
    }
    
    func cardsByType(_ cards:[Card], in section:Int) -> [String:[Card]] {
        let set = self.sets[section]
        
        return self.cardsByType(cards, in: set)
    }
    
    
    func sequenceOfTypesAndCards(_ cards:[Card], by set:CardSet) -> [Any] {
        let cardsByTypes = self.cardsByType(cards, in: set)
        
        var arraySequence = [Any]()
        
        for object in cardsByTypes {
            if object.value.count > 0 {
                arraySequence.append(object.key)
                arraySequence.append(contentsOf: object.value)
            }
        }
        
        return arraySequence
    }
    
    func sequenceOfTypesAndCards(_ cards:[Card], by section:Int) -> [Any] {
        let set = self.sets[section]
        
        return self.sequenceOfTypesAndCards(cards, by: set)
    }
    
    func sequenceOfTypesAndCardsBySection(_ cards:[Card]) -> [CardSet:[Any]] {
        var objects:[CardSet:[Any]] = [CardSet:[Any]]()
        
        var section = 0
        
        for i in 0..<self.sets.count {
            let set = self.sets[i]
            let objectsArray = self.sequenceOfTypesAndCards(cards, by: set)
            if objectsArray.count > 0 {
                objects[set] = objectsArray
                section += 1
            }
        }
        
        
        return objects
    }
    
    //MARK:- Sets
    func setsSordedByDate(cardSets: [CardSet])->[CardSet]{
        
        return cardSets.sorted{ $0.releaseDate < $1.releaseDate }
        
    }
    
}
