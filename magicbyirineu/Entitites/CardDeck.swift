import Foundation

/// Mantem as cartas organizadas
struct CardDeck {
    let identification: CardSet
    private var elements: [Any]

    init(set: CardSet) {
        identification = set
        elements = Array()
    }

    mutating func add(type: String) {
        if !elements.contains(string: type) {
            elements.append(type)
        }
    }

    mutating func add(card: Card) {
        elements.append(card)
    }

    mutating func add(cards: [Card]) {
        elements.append(contentsOf: cards)
    }

    func getElements() -> [Any] {
        return elements
    }

    func getElement(at index: Int) -> Any? {
        if elements.indices.contains(index) {
            return elements[index]
        } else {
            return nil
        }
    }

    func getCards() -> [Card] {
        guard let cards = elements.filter({ $0 is Card }) as? [Card] else {
            return []
        }

        return cards
    }
}
