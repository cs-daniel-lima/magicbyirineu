import Foundation

extension Array where Iterator.Element == CardSet {
    func setFor(card: Card) -> CardSet? {
        let set = filter { $0.code == card.set }

        if !set.isEmpty {
            return set.first
        } else {
            return nil
        }
    }
}
