//
//  CardsLoader.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

protocol CardsLoaderDelegate {
    func loaded(cards:[Card] ,forType type:String, andSet set:CardSet, from loader:CardsLoader)
    func loaded(error:Error)
}

///Carrega cartas de um Set
class CardsLoader {
    
    //MARK: - Properties
    //MARK: Private
    private let cardRepository:CardRepository
    private let cardSetRepository:CardSetRepository
    private let typeRepository:TypeRepository
    
    private var currentType:String?
    private var currentSet:CardSet?
    private var typesIterator:IndexingIterator<[String]>?
    private var setsIterator:IndexingIterator<[CardSet]>?
    private var loadedCards:Array<Card> = Array()
    private var currentPage = 1
    private var requestedCardsCounter = 0
    
    //MARK: Public
    private(set) var types:[String] = [String]()
    private(set) var sets:[CardSet] = [CardSet]()
    
    
    var isSetsAndTypesLoaded:Bool {
        return self.types.count > 0 && self.sets.count > 0
    }
    
    var delegate:CardsLoaderDelegate?
    
    //MARK: - Init
    init(cardRepository:CardRepository, cardSetRepository:CardSetRepository, typeRepository:TypeRepository) {
        self.cardRepository = cardRepository
        self.cardSetRepository = cardSetRepository
        self.typeRepository = typeRepository
    }
    
    //MARK: - Functions
    
    func clean() {
        self.sets = [CardSet]()
        self.types = [String]()
        self.cleanButKeepSetsAndTypes()
    }
    
    func cleanButKeepSetsAndTypes() {
        self.currentSet = nil
        self.currentType = nil
        self.currentPage = 0
        self.requestedCardsCounter = 0
        self.loadedCards = Array()
        self.setsIterator = self.setsIterator?.makeIterator()
        self.typesIterator = self.typesIterator?.makeIterator()
    }
    
    func fetchSets(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.cardSetRepository.fetchCardSets { (result) in
            switch result {
            case .success(let sets):
                self.sets = sets
                self.sets.sort(by: { (before, after) -> Bool in
                    return before.releaseDate > after.releaseDate
                })
                self.setsIterator = self.sets.makeIterator()
                completion?(true)
                
            case .failure(let error):
                self.delegate?.loaded(error: error)
                completion?(false)
            }
        }
    }
    
    func fetchTypes(completion: ((_ success:Bool) -> Void)? = nil ) {
        self.typeRepository.fetchTypes { (result) in
            switch result {
            case .success(let types):
                self.types = types.filter{$0 != "instant"}
                self.types.sort(by: { (before, after) -> Bool in
                    before.compare(after) ==  ComparisonResult.orderedAscending
                })
                self.typesIterator = self.types.makeIterator()
                completion?(true)
                
            case .failure(let error):
                self.delegate?.loaded(error: error)
                completion?(false)
            }
            
        }
    }
    
    func fetchSetsAndTypes(completion: (() -> Void)? = nil ) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        //Pegar Sets
        self.fetchSets { (success) in
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        //Pegar Tipos
        self.fetchTypes { (success) in
            dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
        
        DispatchQueue.main.async {
            completion?()
        }
        
    }
    
    func fetchAllCardFrom(set:CardSet, of type:String, with name:String? = nil, and cards:[Card]? = nil, completion: @escaping ([Card]) -> Void) {
        var allCardsOfASet:[Card]
        
        if let cards = cards {
            allCardsOfASet = cards
        }else{
            allCardsOfASet = [Card]()
        }
        self.cardRepository.fetchCards(page: self.currentPage, name: name, setCode: set.code, type: type, orderParameter: CardOrder.type) {[weak self] (result, header) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let result):
                //Atualizar o contador
                self.updateCounter(on: result.count)
                
                //Atualiza o Tipo
                self.currentType = type
                
                //Adicionar as cartas a um cache local
                allCardsOfASet.append(contentsOf: result)
                
                //Verificar se o contador ja foi chegou na quantidade de cartas estimadas do set
                if let header = header,
                    self.requestedCardsCounter == header.totalCount {
                    
                    //Reseta o contador e page
                    self.requestedCardsCounter = 0
                    self.currentPage = 1
                    
                    //Finaliza função entrgando cartas
                    if let nextType = self.typesIterator?.next() {
                        self.fetchAllCardFrom(set: set, of: nextType, with: name, and: allCardsOfASet, completion: completion)
                        completion(allCardsOfASet)
                    }else{
                        completion(allCardsOfASet)
                        self.typesIterator = self.types.makeIterator()
                    }
                }else{
                    
                    //Atualiza página e chama denovo
                    self.currentPage += 1
                    self.fetchAllCardFrom(set: set, of: type, with: name, and: allCardsOfASet, completion: completion)
                }
                
            case .failure(let error):
                self.delegate?.loaded(error: error)
            }
        }
    }
    
    func fetchCards(with name:String? = nil){
        if !self.isSetsAndTypesLoaded {
            self.fetchSetsAndTypes {
                self.fetchCards(with: name)
            }
            return
        }
        
        //
        if let set = self.setsIterator?.next(),
            let type = self.typesIterator?.next() {
            self.currentSet = set
            self.fetchAllCardFrom(set: set, of: type, with: name) {[weak self] (cards) in
                guard let self = self else {
                    return
                }
                if cards.count > 0 {
                    self.currentSet = set
                    self.delegate?.loaded(cards: cards, forType: self.currentType!, andSet: self.currentSet!, from: self)
                }else{
                    self.fetchCards(with: name)
                }
            }
        }
    }
    
    func updateCounter(on numberOfCards:Int) {
        if self.currentPage == 1 {
            self.requestedCardsCounter = numberOfCards
        }else{
            self.requestedCardsCounter +=  numberOfCards
        }
    }
}
