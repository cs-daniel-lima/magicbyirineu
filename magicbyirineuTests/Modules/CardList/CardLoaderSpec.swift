import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class CardLoaderSpec: QuickSpec {
    override func spec() {
        var cardRepositoryMock: CardRepositoryMock!
        var cardSetRepositoryMock: CardSetRepositoryMock!
        var typeRepositoryMock: TypeRepositoryMock!

        var sut: CardsLoader!

        beforeEach {
            cardRepositoryMock = CardRepositoryMock()
            cardSetRepositoryMock = CardSetRepositoryMock()
            typeRepositoryMock = TypeRepositoryMock()

            sut = CardsLoader(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)
        }

        context("when it is initialized") {
            it("the isSetsAndTypesLoaded must be false") {
                expect(sut.isSetsAndTypesLoaded).to(beFalse())
            }
        }

        context("when it fetchSets is called") {
            beforeEach {
                sut.fetchSets()
            }

            it("the number of sets must be 4") {
                expect(sut.sets.count).to(be(4))
            }

            it("the cleanButKeepSetsAndTypes function must not clean the sets") {
                sut.cleanButKeepSetsAndTypes()
                expect(sut.sets.count).to(be(4))
            }

            it("the clean function must clean the sets") {
                sut.clean()
                expect(sut.sets.count).to(be(0))
            }
        }

        context("when it fetchTypes is called") {
            beforeEach {
                sut.fetchTypes()
            }

            it("the number of types must be 17") {
                expect(sut.types.count).to(be(16))
            }

            it("the cleanButKeepSetsAndTypes function must not clean the types") {
                sut.cleanButKeepSetsAndTypes()
                expect(sut.types.count).to(be(16))
            }

            it("the clean function must clean the types") {
                sut.clean()
                expect(sut.types.count).to(be(0))
            }
        }

        context("when it fetchSets and fetchTypes is called") {
            beforeEach {
                sut.fetchSets()
                sut.fetchTypes()
            }

            it("the isSetsAndTypesLoaded must be true") {
                expect(sut.isSetsAndTypesLoaded).to(beTrue())
            }
        }

        context("when it fetchCards is called") {
            beforeEach {
                sut.clean()
                sut.fetchCards()
            }

            it("the isSetsAndTypesLoaded must be true") {
                expect(sut.isSetsAndTypesLoaded).to(beTrue())
            }
        }
    }
}
