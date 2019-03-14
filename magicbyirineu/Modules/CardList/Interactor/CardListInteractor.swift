import UIKit

protocol CardListInteractorDelegate: class {
    func didLoad()
    func didLoad(error: Error)
}

/// Faz as requisições de dados
class CardListInteractor {
    // MARK: - Properties

    private var fetchedSetCode: String?
    private var fetchedCardsType: String?
    private var currentCardTypePagination: Int = 0
    private var searchingCardsPage: Int = 0
    private var fetchedCardOrganizer: CardOrganizer
    private var searchedCardOrganizer: CardOrganizer
    private var fetchLoadManager: CardsLoader
    private var searchLoadManager: CardsLoader

    private(set) var isSearching: Bool = false

    weak var delegate: CardListInteractorDelegate?

    var waitingAPIResponse = false

    // MARK: - NSObject functions

    init(fetchLoader: CardsLoader, searchLoad: CardsLoader, fetchCardOrganizer: CardOrganizer, searchCardOrganizer: CardOrganizer) {
        fetchLoadManager = fetchLoader
        searchLoadManager = searchLoad

        fetchedCardOrganizer = fetchCardOrganizer
        searchedCardOrganizer = searchCardOrganizer

        fetchLoadManager.delegate = self
        searchLoadManager.delegate = self
    }

    // MARK: - Functions

    func numberOfSets() -> Int {
        if !isSearching {
            return fetchedCardOrganizer.decks.count
        } else {
            return searchedCardOrganizer.decks.count
        }
    }

    func numberOfElementsForSet(setIndex: Int) -> Int {
        var cardOrganizer: CardOrganizer

        if isSearching {
            cardOrganizer = searchedCardOrganizer
        } else {
            cardOrganizer = fetchedCardOrganizer
        }

        if cardOrganizer.decks.indices.contains(setIndex) {
            return cardOrganizer.decks[setIndex].getElements().count
        } else {
            return 0
        }
    }

    func allCards() -> [Card] {
        return fetchLoadManager.cards
    }

    func elementInSet(setIndex: Int, elementIndex: Int) -> Any? {
        var cardOrganizer: CardOrganizer

        if isSearching {
            cardOrganizer = searchedCardOrganizer
        } else {
            cardOrganizer = fetchedCardOrganizer
        }

        return cardOrganizer.getElement(setIndex: setIndex, elementIndex: elementIndex)
    }

    func set(of index: Int) -> CardSet {
        var cardOrganizer: CardOrganizer

        if isSearching {
            cardOrganizer = searchedCardOrganizer
        } else {
            cardOrganizer = fetchedCardOrganizer
        }

        return cardOrganizer.decks[index].identification
    }

    func fetchCards() {
        fetchLoadManager.fetchCards()
        
        if !sets.isEmpty, !types.isEmpty {
            loadManager.loadCards(fromSet: sets[currentSetPagination], withType: types[currentCardTypePagination], page: 1)
        }
    }

    func fetchSearchingCards(cardName: String) {
        isSearching = true
        searchedCardOrganizer.clean()
        searchLoadManager.fetchCards(with: cardName)
    }

    func cancelSearch() {
        searchLoadManager.cleanButKeepSetsAndTypes()
        searchedCardOrganizer.clean()
        isSearching = false
        delegate?.didLoad()
    }
    
    
    func sequenceOfTypesAndCards(_ cards: [Card], by section: Int) -> [Any] {
        let set = sets[section]

        return sequenceOfTypesAndCards(cards, by: set)
    }

    func sequenceOfTypesAndCardsBySection(_ cards: [Card]) -> [CardSet: [Any]] {
        var objects: [CardSet: [Any]] = [CardSet: [Any]]()

        var section = 0

        for i in 0 ..< sets.count {
            let set = sets[i]
            let objectsArray = sequenceOfTypesAndCards(cards, by: set)
            if !objectsArray.isEmpty {
                objects[set] = objectsArray
                section += 1
            }
        }

        return objects
    }

    func appendCards(_: [Card], totalExpected _: Int) {}

    // MARK: - Pagination

    func updatePagination() {
        if !sets.isEmpty {
            fetchedSetCode = sets[currentSetPagination].code
        }

        if !types.isEmpty {
            fetchedCardsType = types[currentCardTypePagination]
        }
    }

    func paginate() {
        waitingAPIResponse = true

        if !isSearching {
            if currentCardTypePagination < types.count - 1 {
                currentCardTypePagination += 1
                fetchCards()
            } else {
                if currentSetPagination < sets.count - 1 {
                    currentSetPagination += 1
                    currentCardTypePagination = 0
                    fetchCards()
                }
            }

        } else {}
    }
}

extension CardListInteractor: CardsLoaderDelegate {
    func loaded(error: Error) {
        delegate?.didLoad(error: error)
    }

    func loaded(cards: [Card], forType type: String, andSet set: CardSet, from loader: CardsLoader) {
        var cardOrganizer: CardOrganizer

        if loader === searchLoadManager {
            cardOrganizer = searchedCardOrganizer
        } else {
            cardOrganizer = fetchedCardOrganizer
        }

        if !cards.isEmpty {
            cardOrganizer.append(cards: cards, set: set, type: type)
            delegate?.didLoad()
            waitingAPIResponse = false
        } else {
            waitingAPIResponse = true
        }
    }
}