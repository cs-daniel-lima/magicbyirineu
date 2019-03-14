import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class CardListInteractorSpec: QuickSpec {
    override func spec() {
        var cardRepositoryMock: CardRepositoryMock!
        var cardSetRepositoryMock: CardSetRepositoryMock!
        var typeRepositoryMock: TypeRepositoryMock!
        var fetchCardLoader: CardsLoaderMock!
        var searchCardLoader: CardsLoaderMock!
        var fetchCardOrganizer: CardOrganizer!
        var searchCardOrganizer: CardOrganizer!

        var sut: CardListInteractor!

        beforeEach {
            cardRepositoryMock = CardRepositoryMock()
            cardSetRepositoryMock = CardSetRepositoryMock()
            typeRepositoryMock = TypeRepositoryMock()

            fetchCardLoader = CardsLoaderMock(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)
            searchCardLoader = CardsLoaderMock(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)

            fetchCardOrganizer = CardOrganizer()
            searchCardOrganizer = CardOrganizer()

            sut = CardListInteractor(fetchLoader: fetchCardLoader, searchLoad: searchCardLoader, fetchCardOrganizer: fetchCardOrganizer, searchCardOrganizer: searchCardOrganizer)
        }

        context("when it is initialized") {
            it("the isSearching must be false") {
                expect(sut.isSearching).notTo(beTrue())
            }

            it("the waitingAPIResponse must be false") {
                expect(sut.waitingAPIResponse).notTo(beTrue())
            }

            it("the delegate must be nil") {
                expect(sut.delegate).to(beNil())
            }

            it("the number of sets must be 0") {
                expect(sut.numberOfSets()).to(be(0))
            }

            it("the delegate of the laoders must be the CardListInteractor") {
                expect(fetchCardLoader.delegate).to(be(sut))
                expect(searchCardLoader.delegate).to(be(sut))
            }
        }

        context("when fetchCard is called and success") {
            beforeEach {
                fetchCardLoader.isFetchedSuccess = true
                sut.fetchCards()
            }

            it("the isSearching must be false") {
                expect(sut.isSearching).notTo(beTrue())
            }

            it("the number of sets must be 1") {
                expect(sut.numberOfSets()).to(be(1))
            }

            it("the number of elements for set must be 5, which are 1 type (String) and 5 cards (Card)") {
                expect(sut.numberOfElementsForSet(setIndex: 0)).to(be(6))
            }

            it("the first element from the set must be of kind 'String'") {
                expect(sut.elementInSet(setIndex: 0, elementIndex: 0)).to(beAKindOf(String.self))
            }

            it("the second element from the set must be of kind 'Card'") {
                expect(sut.elementInSet(setIndex: 0, elementIndex: 1)).to(beAKindOf(Card.self))
            }

            it("the first set musr be called 'Set A'") {
                expect(sut.set(of: 0).name).to(be("Set A"))
            }
        }

        context("when fetchCard is called and fail") {
            beforeEach {
                fetchCardLoader.isFetchedSuccess = false
                sut.fetchCards()
            }

            it("the number of sets must be 1") {
                expect(sut.numberOfSets()).to(be(0))
            }

            it("the number of elements for set must be 4, which are 1 type (String) and 3 cards (Card)") {
                expect(sut.numberOfElementsForSet(setIndex: 0)).to(be(0))
            }
        }

        context("when fetchCardSearching is called passing the cardName 'Card B' and success") {
            beforeEach {
                searchCardLoader.isFetchedSuccess = true
                sut.fetchSearchingCards(cardName: "Forest")
            }

            it("the isSearching must be true") {
                expect(sut.isSearching).to(beTrue())
            }

            it("the number of sets must be 1") {
                expect(sut.numberOfSets()).to(be(1))
            }

            it("the number of elements for set must be 4, which are 1 type (String) and 1 cards (Card)") {
                expect(sut.numberOfElementsForSet(setIndex: 0)).to(be(2))
            }

            it("the first element from the set must be of kind 'String'") {
                expect(sut.elementInSet(setIndex: 0, elementIndex: 0)).to(beAKindOf(String.self))
            }

            it("the second element from the set must be of kind 'Card'") {
                expect(sut.elementInSet(setIndex: 0, elementIndex: 1)).to(beAKindOf(Card.self))
            }

            it("the first set musr be called 'Set A'") {
                expect(sut.set(of: 0).name).to(be("Set A"))
            }
        }

        context("when fetchCardSearching is called passing a card name which not exist and success") {
            beforeEach {
                searchCardLoader.isFetchedSuccess = true
                sut.fetchSearchingCards(cardName: "Not Exist")
            }

            it("the number of sets must be 1") {
                expect(sut.numberOfSets()).to(be(0))
            }

            it("the number of elements for set must be 4, which are 1 type (String) and 3 cards (Card)") {
                expect(sut.numberOfElementsForSet(setIndex: 0)).to(be(0))
            }
        }

        context("when fetchCardSearching is called and fail") {
            beforeEach {
                searchCardLoader.isFetchedSuccess = false
                sut.fetchSearchingCards(cardName: "Card B")
            }

            it("the number of sets must be 1") {
                expect(sut.numberOfSets()).to(be(0))
            }

            it("the number of elements for set must be 4, which are 1 type (String) and 3 cards (Card)") {
                expect(sut.numberOfElementsForSet(setIndex: 0)).to(be(0))
            }
        }
    }
}
