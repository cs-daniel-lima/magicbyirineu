import Foundation

/// Organiza as cartas
class CardOrganizer {
    var decks: [CardDeck] = Array()

    private var lastSet: CardSet?

    func append(cards: [Card], set: CardSet, type: String) {
        // Se for um Set novo cria-se um deck
        if lastSet == nil || lastSet != set {
            lastSet = set
            var deck = CardDeck(set: set)
            deck.add(type: type)
            deck.add(cards: cards)
            decks.append(deck)
        } else {
            decks[self.decks.count - 1].add(type: type)
            decks[self.decks.count - 1].add(cards: cards)
        }
    }

    func getElement(setIndex: Int, elementIndex: Int) -> Any? {
        if decks.indices.contains(setIndex) {
            return decks[setIndex].getElement(at: elementIndex)
        } else {
            return nil
        }
    }

    func clean() {
        decks = Array()
        lastSet = nil
    }
}
