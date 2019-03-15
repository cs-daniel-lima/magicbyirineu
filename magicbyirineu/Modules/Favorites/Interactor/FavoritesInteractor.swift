import Foundation

class FavoritesInteractor {
    var sets = [CardSet]()
    var types = [String]()
    var decks = [CardDeck]()

    var databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func fetchData() {
        sets = [CardSet]()
        types = [String]()
        decks = [CardDeck]()

        sets = databaseManager.getSets()
        types = databaseManager.getTypes()

        for set in sets {
            var deck = CardDeck(set: set)

            for type in types {
                let cardsFormDatabase = databaseManager.getCards(setCode: set.code, type: type)

                if !cardsFormDatabase.isEmpty {
                    deck.add(type: type)
                    deck.add(cards: cardsFormDatabase)
                }
            }

            decks.append(deck)
        }
    }

    func numberOfElementsForSet(setIndex: Int) -> Int {
        if decks.indices.contains(setIndex) {
            return decks[setIndex].getElements().count
        } else {
            return 0
        }
    }

    func elementInSet(setIndex: Int, elementIndex: Int) -> Any? {
        if decks.indices.contains(setIndex) {
            return decks[setIndex].getElement(at: elementIndex)
        } else {
            return nil
        }
    }

    func allCards() -> [Card] {
        var cards = [Card]()

        for deck in decks {
            cards.append(contentsOf: deck.getCards())
        }

        return cards
    }

    func search(name: String) {
        decks = [CardDeck]()

        for set in sets {
            var deck = CardDeck(set: set)

            for type in types {
                let cardsFormDatabase = databaseManager.getCards(setCode: set.code, type: type, name: name)

                if !cardsFormDatabase.isEmpty {
                    deck.add(type: type)
                    deck.add(cards: cardsFormDatabase)
                    decks.append(deck)
                }
            }
        }
    }
}
