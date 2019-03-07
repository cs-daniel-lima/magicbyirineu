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

enum CardOrder:String{
    case name = "name"
    case type = "type"
}

class CardListInteractor: NSObject {
    
    //MARK: - Properties
    
    var cardRepository:CardRepository
    var cardSetRepository:CardSetRepository
    var typeRepository:TypeRepository
    
    var fetchedCardsPage:Int = 1
    var currentSetPagination:Int = 0
    
    private var fetchedCards:[Card] = [Card]()
    private var searchedCards:[Card] = [Card]()
    
    private var fetchedSetCode:String?
    private var fetchedCardsType:String?
    private var currentCardTypePagination:Int = 0
    private var searchingCardsPage:Int = 0
    
    private var isLoaded:Bool {
        return self.sets.count != 0 && self.types.count != 0
    }
    
    private(set) var isSearching:Bool = false
    
    weak var delegate:CardListInteractorDelegate?
    
    var waitingAPIResponse = false
    
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
    
    var cardOrganizer:CardOrganizer
    var loadManager:LoadManager
    
    //MARK: - NSObject functions
    init(cardRepository:CardRepository, cardSetRepository:CardSetRepository, typeRepository:TypeRepository) {
        self.cardRepository = cardRepository
        self.cardSetRepository = cardSetRepository
        self.typeRepository = typeRepository
        
        self.cardOrganizer = CardOrganizer()
        self.loadManager = LoadManager()
        
        super.init()
        
        self.loadManager.delegate = self
        
        self.fetchTypes { (result) in  
            self.fetchSets { (result) in
                self.fetchCards()
            }
        }
    }
    
    
    //MARK: - Functions
    //MARK: Private
    private func cleanSearchData() {
        self.searchingCardsPage = 1
        self.searchedCards = [Card]()
    }
    
    private func cleanCardsData() {
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
    
    func numberOfSets()->Int{
        
        if(!isSearching){
            return cardOrganizer.decks.count
        }else{
            return objectsBySet.keys.count
        }
    }
    
    func numberOfElementsForSet(setIndex:Int)->Int{
        
        if(cardOrganizer.decks.indices.contains(setIndex)){
            return cardOrganizer.decks[setIndex].getElements().count
        }else{
            return 0
        }
        
    }
    
    func getElementInSet(setIndex:Int, elementIndex:Int)->Any?{
        
        if(!isSearching){
            
            return cardOrganizer.getElement(setIndex: setIndex, elementIndex: elementIndex)
            
        }else{
            
            let keys = objectsBySet.keys.map { (set) -> CardSet in
                return set
            }
            let set = keys[setIndex]
            
            guard let objectList = self.objectsBySet[set] else {
                Logger.logError(in: self, message: "Could not get the objectList from CardSet:\(set)")
                return CGSize.zero
            }
            
            return objectList[elementIndex]
            
        }
        
        
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
                self.updatePagination()
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
                self.types = types.filter{$0 != "instant"}
                completion?(true)
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
                completion?(false)
            }
            
        }
    }
    
    func fetchCards(){
        
        loadManager.loadCards(fromSet: sets[currentSetPagination], withType: types[currentCardTypePagination], page: 1)
        
    }
    
    func fetchCards(completion: @escaping (_ success:Bool) -> Void) {
        if self.isLoaded {
            
            self.cardRepository.fetchCards(page: self.fetchedCardsPage, name: nil, setCode: self.fetchedSetCode, type: self.fetchedCardsType, orderParameter: CardOrder.name, completion: { (result, totalCount) in
                switch result {
                case .success(let cardsResponse):
                    self.fetchedCardsPage += 1
                    
                    if let total = totalCount{
                        self.appendCards(cardsResponse, totalExpected: total)
                    }
                    
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
        self.cleanSearchData()
        self.isSearching = true
        self.searchingCardsPage += 1
        
        self.cardRepository.fetchCards(page: self.searchingCardsPage, name:cardName , setCode: nil, type: nil, orderParameter: CardOrder.type) { (result, totalCount) in
            switch result {
            case .success(let cards):
                self.searchedCards.append(contentsOf: cards)
                self.objectsBySet = self.sequenceOfTypesAndCardsBySection(self.cards)
                self.delegate?.didLoad()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    //MARK: Public
    func cancelSearch() {
        self.cleanSearchData()
        self.isSearching = false
        delegate?.didLoad()
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
    
    func appendCards(_ cards:[Card], totalExpected:Int){
        
        
        
    }
    
    //MARK:- Pagination
    func updatePagination(){
        fetchedSetCode = sets[currentSetPagination].code
        fetchedCardsType = types[currentCardTypePagination]
    }
    
    func paginate(){
        
        waitingAPIResponse = true
        
        if(!isSearching){
            
            if(currentCardTypePagination < types.count - 1){
                currentCardTypePagination += 1
                fetchCards()
            }else{
                if(currentSetPagination < sets.count - 1){
                    currentSetPagination += 1
                    currentCardTypePagination = 0
                    fetchCards()
                }
            }
            
        }else{
            
            
        }
        
    }
    
    
    
}
