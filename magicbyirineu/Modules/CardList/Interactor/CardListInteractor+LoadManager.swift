import Foundation

extension CardListInteractor: LoadManagerDelegate {
    func loaded(cards: [Card], forType type: String, andSet set: CardSet) {
        if !cards.isEmpty {
            cardOrganizer.append(cards: cards, set: set, type: type, setIndex: currentSetPagination)
            delegate?.didLoad()
            waitingAPIResponse = false

        } else {
            waitingAPIResponse = true
            paginate()
        }
    }

    func requestApiCardsDataFor(set: CardSet?, andType type: String?, withPage page: Int) {
        if let setToload = set, let typeToLoad = type {
            cardRepository.fetchCards(page: page, name: nil, setCode: setToload.code, type: typeToLoad, orderParameter: CardOrder.name, completion: { result, totalCount in
                switch result {
                case let .success(cardsResponse):

                    if let total = totalCount {
                        self.loadManager.appendCards(cardsResponse, totalExpected: total)
                    }

                case let .failure(error):
                    self.delegate?.didLoad(error: error)
                }
            })
        }
    }
}
