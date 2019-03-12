import Foundation

protocol LoadManagerDelegate {
    func requestApiCardsDataFor(set: CardSet?, andType type: String?, withPage page: Int)
    func loaded(cards: [Card], forType type: String, andSet set: CardSet)
}

class CardsLoader {
    var delegate: LoadManagerDelegate?

    private var currentType: String?
    private var currentSet: CardSet?
    private var currentPage = 0
    private var loadedCards: [Card] = Array()

    private var tempCount = 0

    func loadCards(fromSet set: CardSet, withType type: String, page: Int) {
        currentType = type
        currentSet = set
        currentPage = page
        loadedCards = Array()

        requestCards()
    }

    func requestCards() {
        delegate?.requestApiCardsDataFor(set: currentSet, andType: currentType, withPage: currentPage)
    }

    func appendCards(_ cards: [Card], totalExpected: Int) {
        loadedCards = cards

        if currentPage == 1 {
            tempCount = loadedCards.count
        } else {
            tempCount += loadedCards.count
        }

        if tempCount == totalExpected {
            if let type = currentType, let set = currentSet {
                delegate?.loaded(cards: loadedCards, forType: type, andSet: set)
            }

        } else {
            currentPage += 1
            requestCards()
        }
    }
}
