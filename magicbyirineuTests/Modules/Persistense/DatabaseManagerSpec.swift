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

            it("has storedTypes count equal to 3") {
                expect(storedTypes.count).to(equal(3))
            }

            it("has storedSets count equal to 4") {
                expect(storedSets.count).to(equal(4))
            }

            context("when searching for specific card name") {
                var specificCards: [Card]!

                beforeEach {
                    specificCards = sut.getCards(name: "Forest")
                }

                it("has specificCards count equal to 1") {
                    expect(specificCards.count).to(equal(1))
                }

                it("found card has set equal to 2ED") {
                    expect(specificCards.first?.set).to(equal("2ED"))
                }

                it("found card imageUrl is not null") {
                    expect(specificCards.first?.imageUrl).toNot(beNil())
                }

                it("found card har foreignNames count equal to 1") {
                    expect(specificCards.first?.foreignNames?.count).to(equal(1))
                }

                it("found card har foreignName equal to Floresta") {
                    expect(specificCards.first?.foreignNames?.first?.name).to(equal("Floresta"))
                }
            }

            context("when searching for specific card name specific setcode") {
                var specificCards: [Card]!

                beforeEach {
                    specificCards = sut.getCards(name: "Time Sieve", setCode: "10E")
                }

                it("has specificCards count equal to 1") {
                    expect(specificCards.count).to(equal(1))
                }

                it("found card has set equal to 10E") {
                    expect(specificCards.first?.set).to(equal("10E"))
                }

                it("found card imageUrl is not null") {
                    expect(specificCards.first?.imageUrl).to(beNil())
                }

                it("found card har foreignNames count equal to 1") {
                    expect(specificCards.first?.foreignNames?.count).to(equal(1))
                }

                it("found card har foreignName equal to Peneira de Tempo") {
                    expect(specificCards.first?.foreignNames?.first?.name).to(equal("Peneira de Tempo"))
                }
            }
        }
    }
}
