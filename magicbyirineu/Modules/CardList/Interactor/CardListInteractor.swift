import UIKit

protocol CardListInteractorDelegate: class {
    func didLoad()
    func didLoad(error: Error)
}

///Faz as requisições de dados
class CardListInteractor {
    
    //MARK: - Properties
    private var fetchedSetCode:String?
    private var fetchedCardsType:String?
    private var currentCardTypePagination:Int = 0
    private var searchingCardsPage:Int = 0
    private var fetchedCardOrganizer:CardOrganizer
    private var searchedCardOrganizer:CardOrganizer
    private var fetchLoadManager:CardsLoader
    private var searchLoadManager:CardsLoader
    
    private(set) var isSearching:Bool = false
    
    weak var delegate:CardListInteractorDelegate?
    
    var waitingAPIResponse = false
    
    //MARK: - NSObject functions
    init(fetchLoader:CardsLoader, searchLoad:CardsLoader, fetchCardOrganizer:CardOrganizer, searchCardOrganizer:CardOrganizer) {
        
        self.fetchLoadManager = fetchLoader
        self.searchLoadManager = searchLoad
        
        self.fetchedCardOrganizer = fetchCardOrganizer
        self.searchedCardOrganizer = searchCardOrganizer
        
        self.fetchLoadManager.delegate = self
        self.searchLoadManager.delegate = self
    }
    
    //MARK: - Functions
    func numberOfSets() -> Int {
        if !self.isSearching {
            return self.fetchedCardOrganizer.decks.count
        }else{
            return self.searchedCardOrganizer.decks.count
        }
    }
    
    func numberOfElementsForSet(setIndex:Int) -> Int {
        var cardOrganizer:CardOrganizer
        
        if self.isSearching {
            cardOrganizer = self.searchedCardOrganizer
        }else{
            cardOrganizer = self.fetchedCardOrganizer
        }
        
        if cardOrganizer.decks.indices.contains(setIndex) {
            return cardOrganizer.decks[setIndex].getElements().count
        } else {
            return 0
        }
    }
    
    func elementInSet(setIndex:Int, elementIndex:Int) -> Any? {
        var cardOrganizer:CardOrganizer
        
        if self.isSearching {
            cardOrganizer = self.searchedCardOrganizer
        }else{
            cardOrganizer = self.fetchedCardOrganizer
        }
       
        return cardOrganizer.getElement(setIndex: setIndex, elementIndex: elementIndex)
    }
    
    func set(of index:Int) -> CardSet {
        var cardOrganizer:CardOrganizer
        
        if self.isSearching {
            cardOrganizer = self.searchedCardOrganizer
        }else{
            cardOrganizer = self.fetchedCardOrganizer
        }
        
        return cardOrganizer.decks[index].identification
    }
    
    //MARK: Public
    func fetchCards() {
        self.fetchLoadManager.fetchCards()
    }
    
    func fetchSearchingCards(cardName:String) {
        self.isSearching = true
        self.searchedCardOrganizer.clean()
        self.searchLoadManager.fetchCards(with: cardName)
    }

    // MARK: Public

    func cancelSearch() {
        self.searchLoadManager.cleanButKeepSetsAndTypes()
        self.searchedCardOrganizer.clean()
        self.isSearching = false
        self.delegate?.didLoad()
    }
}

extension CardListInteractor: CardsLoaderDelegate {
    func loaded(error: Error) {
        self.delegate?.didLoad(error: error)
    }
    
    func loaded(cards: [Card], forType type: String, andSet set: CardSet, from loader:CardsLoader) {
        var cardOrganizer:CardOrganizer
        
        if loader === self.searchLoadManager {
            cardOrganizer = self.searchedCardOrganizer
        } else {
            cardOrganizer = self.fetchedCardOrganizer
        }
        
        if cards.count > 0 {
            cardOrganizer.append(cards: cards, set: set, type: type)
            self.delegate?.didLoad()
            self.waitingAPIResponse = false
        }else{
            self.waitingAPIResponse = true
        }
    }
}
