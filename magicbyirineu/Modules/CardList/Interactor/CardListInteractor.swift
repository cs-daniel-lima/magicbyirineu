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
    
    enum Status {
        case normal
        case loading
        case searching(String)
    }
    
    enum Constant:String {
        case notificationUpdatedStatus = "CardsCollectionInteractor.updatedStatus"
    }
    
    //MARK: - Properties
    weak var delegate:CardListInteractorDelegate?
    
    private var apiManager:APIManager
    
    private(set) var sets:[CardSet] = [CardSet]()
    private(set) var categories:[String] = [String]()
    
    private var fetchedCards:[Card] = [Card]()
    private var searchedCards:[Card] = [Card]()
    var cards:[Card] {
        switch self.status {
        case .normal:
            return self.fetchedCards
        case .searching(_):
            return self.searchedCards
        case .loading:
            return [Card]()
        }
        
        return [Card]()
    }
    
    private var cardsPage:Int = 0
    private var searchingCardsPage:Int = 0
    private(set) var pageLastModified:Int = 0
    var page:Int {
        switch self.status {
        case .normal:
            return self.cardsPage
        case .searching:
            return self.searchingCardsPage
        case .loading:
            return 0
        }
    }
    
    
    private var _status:Status = .normal
    private(set) var status:Status {
        get{
            if self.sets.count == 0 || self.categories.count == 0 {
                return .loading
            }else{
                return _status
            }
        }
        set{
            _status = newValue
        }
    }
    
    var objectsBySet:[Int:[Any]] = [Int:[Any]]()
    
    //MARK: - NSObject functions
    init(apiManager:APIManager) {
        self.apiManager = apiManager
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CardListInteractor.updatedStatus), name: NSNotification.Name(rawValue: Constant.notificationUpdatedStatus.rawValue), object: nil)
        
        self.fetchSets()
        self.fetchCategories()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        self.cardsPage = 1
        self.fetchedCards = [Card]()
    }
    
    private func cleanAll() {
        self.cleanSearchData()
        self.cleanCardsData()
    }
    
    func fetchSets() {
        let request = EndpointSets()
        self.apiManager.fetch(request) { (result) in
            switch result {
            case .success(let response):
                self.sets = response.sets
                self.postStatus()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetchCategories() {
        let request = EndpointCategories()
        self.apiManager.fetch(request) { (result) in
            switch result {
            case .success(let response):
                self.categories = response.types
                self.postStatus()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetchCards(page:Int? = 0) {
        self.pageLastModified = self.page
        if let pageVerified = page {
            if pageVerified >= self.page {
                self.cardsPage = pageVerified
            } else {
                self.cardsPage = self.page <= 1 ? 1: self.cardsPage - 1
            }
        }
        
        let request = EndpointCards(page: page, name: nil)
        self.apiManager.fetch(request) { (result) in
            switch result {
            case .success(let response):
                self.fetchedCards.append(contentsOf: response.cards)
                self.objectsBySet = self.sequenceOfCategoriesAndCardsBySection()
                self.delegate?.didLoad()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetchSearchingCards(page:Int? = 0, cardName:String) {
        self.pageLastModified = self.page
        if let pageVerified = page {
            if pageVerified >= self.page {
                self.searchingCardsPage = pageVerified
            } else {
                self.searchingCardsPage = self.page <= 1 ? 1: self.searchingCardsPage - 1
            }
        }
        
        let request = EndpointCards(page: page, name: cardName)
        self.apiManager.fetch(request) { (result) in
            switch result {
            case .success(let response):
                self.searchedCards.append(contentsOf: response.cards)
                self.objectsBySet = self.sequenceOfCategoriesAndCardsBySection()
                self.delegate?.didLoad()
                
            case .failure(let error):
                self.delegate?.didLoad(error: error)
            }
        }
    }
    
    func fetch(page: Int? = nil) {
        //Activate search
        switch self.status {
        case .normal:
            self.fetchCards(page: page)
        case .searching(let query):
            self.fetchSearchingCards(page: page, cardName: query)
        case .loading:
            self.fetchSets()
            self.fetchCards()
        }
    }
    
    //MARK: Public
    func reload() {
        self.cleanAll()
        
        self.fetch()
    }
    
    func cancelSearch() {
        self.cleanSearchData()
        self.status = .normal
        self.objectsBySet = self.sequenceOfCategoriesAndCardsBySection()
    }
    
    func change(status: Status) {
        self.cleanSearchData()
        self.status = status
    }
    
    
    
    func postStatus() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: Constant.notificationUpdatedStatus.rawValue)))
    }
    
    @objc func updatedStatus() {
        switch self.status {
        case .normal:
            self.fetch()
        case .loading:
            break
        case .searching(_):
            break
        }
    }
    
    
    //MARK Card
    func cards(from category:String, in set:CardSet) -> [Card] {
        let someCards = self.cards.filter { (card) -> Bool in
            return (card.set == set.code && card.types.contains(category))
        }
        
        return someCards.sorted { (before, after) -> Bool in
            return before.name.compare(after.name) == .orderedAscending
        }
    }
    
    func cardsByCategories(in set:CardSet) -> [String:[Card]] {
        var cardsByCategories:[String:[Card]] = [String:[Card]]()
        
        for category in categories {
            cardsByCategories[category] = self.cards(from: category, in: set)
        }
        
        return cardsByCategories
    }
    
    func cardsByCategories(in section:Int) -> [String:[Card]] {
        let set = self.sets[section]
        
        return self.cardsByCategories(in: set)
    }
    
    
    func sequenceOfCategoriesAndCards(by set:CardSet) -> [Any] {
        let cardsByCategories = self.cardsByCategories(in: set)
        
        var arraySequence = [Any]()
        
        for object in cardsByCategories {
            if object.value.count > 0 {
                arraySequence.append(object.key)
                arraySequence.append(contentsOf: object.value)
            }
        }
        
        return arraySequence
    }
    
    func sequenceOfCategoriesAndCards(by section:Int) -> [Any] {
        let set = self.sets[section]
        
        return self.sequenceOfCategoriesAndCards(by: set)
    }
    
    func sequenceOfCategoriesAndCardsBySection() -> [Int:[Any]] {
        var objects:[Int:[Any]] = [Int:[Any]]()
        
        for i in 0..<self.sets.count {
            let set = self.sets[i]
            let objectsArray = self.sequenceOfCategoriesAndCards(by: set)
            if objectsArray.count > 0 {
                objects[i] = objectsArray
            }
        }
        
        return objects
    }
}
