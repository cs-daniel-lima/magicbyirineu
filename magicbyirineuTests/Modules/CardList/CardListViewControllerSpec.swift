import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class CardListViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: CardListViewController!

        beforeEach {
            let cardRepositoryMock = CardRepositoryMock()
            let cardSetRepositoryMock = CardSetRepositoryMock()
            let typeRepositoryMock = TypeRepositoryMock()

            let fetchCardLoader = CardsLoaderMock(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)
            let searchCardLoader = CardsLoaderMock(cardRepository: cardRepositoryMock, cardSetRepository: cardSetRepositoryMock, typeRepository: typeRepositoryMock)

            let fetchCardOrganizer = CardOrganizer()
            let searchCardOrganizer = CardOrganizer()

            let interactor = CardListInteractor(fetchLoader: fetchCardLoader, searchLoad: searchCardLoader, fetchCardOrganizer: fetchCardOrganizer, searchCardOrganizer: searchCardOrganizer)

            sut = CardListViewController(title: "CardList")
            sut.presenter = CardListPresenterMock(router: CardListRouter(), interactor: interactor, view: sut)
            UIApplication.shared.keyWindow?.rootViewController = sut
        }

        context("when it is initialized") {
            it("should view match with snapshot") {
                self.tester().waitForAnimationsToFinish()
                expect(sut) == snapshot()
            }

            it("isFirstLoad should begin as true", closure: {
                expect(sut.presenter?.isFirstLoad).to(beTrue())
            })

            it("router should not be nil", closure: {
                expect(sut.presenter?.router).notTo(beNil())
            })

            it("interactor should not be nil", closure: {
                expect(sut.presenter?.interactor).notTo(beNil())
            })
        }

        context("on cardListPresenter life cycle") {
            it("shoud call numberOfSections", closure: {
                self.tester().waitForAnimationsToFinish()
                expect((sut.presenter as! CardListPresenterMock).wasNumberOfSectionCalled).to(beTrue())
            })

            it("should call numberOfSections", closure: {
                self.tester().waitForAnimationsToFinish()
                expect((sut.presenter as! CardListPresenterMock).wasCellForItemAtCalled).to(beTrue())
            })

            context("when querying for cards", {
                it("should display the activity indicator", closure: {
                    sut.set(status: .searching)
                    self.tester().waitForAnimationsToFinish()
                    expect(sut) == snapshot()
                })
            })

            context("Regarding loaded cards", {
                var cards = [Card]()

                beforeEach {
                    sut.presenter.interactor!.fetchCards()

                    cards = []

                    let card1 = sut.presenter.interactor!.elementInSet(setIndex: 0, elementIndex: 1)
                    let card2 = sut.presenter.interactor!.elementInSet(setIndex: 0, elementIndex: 2)
                    let card3 = sut.presenter.interactor!.elementInSet(setIndex: 0, elementIndex: 3)
                    let card4 = sut.presenter.interactor!.elementInSet(setIndex: 0, elementIndex: 4)

                    cards.append(card1 as! Card)
                    cards.append(card2 as! Card)
                    cards.append(card3 as! Card)
                    cards.append(card4 as! Card)
                }

                context("when imageUrl exists and foreignLanguage exists", {
                    it("should display the main image", closure: {
                        expect(cards[0].imageUrl).notTo(beNil())
                        expect(cards[0].foreignNames).notTo(beNil())
                    })
                })

                context("when imageUrl exists and foreignLanguage doesn't", {
                    it("should display the main image", closure: {
                        expect(cards[1].imageUrl).notTo(beNil())
                        expect(cards[1].foreignNames).to(beNil())
                    })
                })

                context("when imageUrl doens't exists and foreignLanguage exists", {
                    it("should display a foreign language", closure: {
                        expect(cards[2].imageUrl).to(beNil())
                        expect(cards[2].foreignNames).notTo(beNil())

                    })
                })

                context("when imageUrl doesn't exists and foreignLanguage doesn't exists", {
                    it("should display a placeholder image", closure: {
                        expect(cards[3].imageUrl).to(beNil())
                        expect(cards[3].foreignNames).to(beNil())

                    })
                })

            })
        }
    }
}
