import Foundation
import Realm
import RealmSwift

protocol CardDetailInteractorDelegate {
    func didChangeSelectedCard()
}

class CardDetailInteractor {
    var delegate: CardDetailInteractorDelegate?

    let sets: [CardSet]
    let cards: [Card]
    var selectedCard: Card

    var dbManager: DatabaseManager

    init(cards: [Card], selectedCard: Card, sets: [CardSet]) {
        self.cards = cards
        self.sets = sets
        self.selectedCard = selectedCard

        let realm = try! Realm(configuration: Utils.createConfigurationFile())
        dbManager = DatabaseManager(realm: realm)
    }

    func changeSelectedCard(index: Int) {
        selectedCard = cards[index]
        delegate?.didChangeSelectedCard()
    }

    func indexOfSelectedCard() -> Int {
        guard let index = cards.firstIndex(where: { (card) -> Bool in
            card == selectedCard
        }) else {
            return 0
        }

        return index
    }

    func saveCardAsFavorite() {
        if let set = self.sets.setFor(card: self.selectedCard) {
            dbManager.addFavorite(card: selectedCard, set: set)
        }
    }

    func removeCardFromFavorite() {
        if let set = self.sets.setFor(card: self.selectedCard) {
            dbManager.removeFavorite(card: selectedCard, set: set)
        }
    }
}
