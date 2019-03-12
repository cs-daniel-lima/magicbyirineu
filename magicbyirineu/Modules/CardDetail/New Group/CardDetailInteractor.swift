import Foundation

class CardDetailInteractor {
    let cards: [Card]
    var selectedCard: Card

    init(cards: [Card], selectedCard: Card) {
        self.cards = cards
        self.selectedCard = selectedCard
    }

    func changeSelectedCard(index: Int) {
        selectedCard = cards[index]
    }

    func indexOfSelectedCard() -> Int {
        guard let index = cards.firstIndex(where: { (card) -> Bool in
            card == selectedCard
        }) else {
            return 0
        }

        return index
    }
}
