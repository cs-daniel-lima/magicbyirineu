import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class DatabaseManagerSpec: QuickSpec {
    override func spec() {
        var sut: DatabaseManagerMock!
        var cards: [Card]!
        var sets: [CardSet]!

        beforeEach {
            sut = DatabaseManagerMock()

            let cardsRepository = CardRepositoryMock()
            let setsRepository = CardSetRepositoryMock()

            cardsRepository.fetchCards(page: 1, name: nil, setCode: nil, type: nil, orderParameter: nil, completion: { result, _ in

                switch result {
                case let .success(cardsResponse):
                    cards = cardsResponse
                case .failure:
                    cards = []
                }

            })

            setsRepository.fetchCardSets(completion: { result in

                switch result {
                case let .success(setsResponse):
                    sets = setsResponse
                case .failure:
                    sets = []
                }

            })
        }

        context("when cards are favorited") {
            var storedCards: [Card]!
            var storedTypes: [String]!
            var storedSets: [CardSet]!

            beforeEach {
                sut.eraseAllData()

                for card in cards {
                    if let set = sets.setFor(card: card) {
                        sut.addFavorite(card: card, set: set)
                    }
                }

                storedCards = sut.getCards(forSets: sets)
                storedTypes = sut.getTypes()
                storedSets = sut.getSets()
            }

            it("has storedCards count equal to 5") {
                expect(storedCards.count).to(equal(5))
            }

            it("has storedTypes count equal to 10") {
                expect(storedTypes.count).to(equal(10))
            }

            it("has storedSets count equal to 5") {
                expect(storedSets.count).to(equal(5))
            }
        }
    }
}
