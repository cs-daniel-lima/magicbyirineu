import Nimble
import Nimble_Snapshots
import Quick
import Realm
import RealmSwift

@testable import magicbyirineu

class DatabaseManagerSpec: QuickSpec {
    override func spec() {
        var testRealm: Realm!
        var sut: DatabaseManager!
        var cards: [Card]!
        var sets: [CardSet]!

        beforeEach {
            testRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "DatabaseManagerSpec"))

            sut = DatabaseManager(realm: testRealm)

            cards = CardRepositoryMock.mockCardsList()
            sets = CardSetRepositoryMock.mockCardsSet()
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

                it("has every card from specificCards array identified as favorited") {
                    for card in specificCards {
                        expect(sut.isfavorited(card: card)).to(beTrue())
                    }
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

            context("when searching for specific card name and specific setcode") {
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

            context("when one card is removed from favorites") {
                var cardToRemove: Card!
                var remainingCards: [Card]!

                beforeEach {
                    cardToRemove = storedCards.first!
                    sut.removeFavorite(card: cardToRemove, set: storedSets.setFor(card: cardToRemove)!)
                    remainingCards = sut.getCards(forSets: storedSets)
                }

                it("has the removed car identified as not favorited") {
                    expect(sut.isfavorited(card: cardToRemove)).to(beFalse())
                }

                it("has remainingCards count equal to 4") {
                    expect(remainingCards.count).to(equal(4))
                }
            }

            context("when all cards are removed from favorites") {
                var remaingingCards: [Card]!
                var remainingTypes: [String]!
                var remainingSets: [CardSet]!

                beforeEach {
                    for card in storedCards {
                        sut.removeFavorite(card: card, set: storedSets.setFor(card: card)!)
                    }

                    remaingingCards = sut.getAllCards()
                    remainingSets = sut.getSets()
                    remainingTypes = sut.getTypes()
                }

                it("has empty remaingingCards") {
                    expect(remaingingCards.isEmpty).to(beTrue())
                }

                it("has empty remainingTypes") {
                    expect(remainingTypes.isEmpty).to(beTrue())
                }

                it("has empty remainingSets") {
                    expect(remainingSets.isEmpty).to(beTrue())
                }
            }
        }
    }
}
