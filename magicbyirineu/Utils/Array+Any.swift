import Foundation

extension Array where Iterator.Element == Any {
    func contains(string: String) -> Bool {
        if let elements: [String] = self.filter({ $0 is String }) as? [String] {
            if elements.contains(string) {
                return true
            } else {
                return false
            }

        } else {
            return false
        }
    }

    func contains(card: Card) -> Bool {
        if let elements: [Card] = self.filter({ $0 is Card }) as? [Card] {
            let matchingCards = elements.filter { $0.id == card.id }

            if !matchingCards.isEmpty {
                return true
            } else {
                return false
            }

        } else {
            return false
        }
    }

    mutating func appendCards(_ cards: [Card]) {
        for c in cards {
            if !contains(card: c) {
                append(c)
            }
        }
    }
}
