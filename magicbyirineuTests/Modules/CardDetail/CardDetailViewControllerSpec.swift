import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class CardDetailViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: CardDetailViewController!
        var cards: [Card]!

        beforeEach {
            let repository = CardRepositoryMock()

            repository.fetchCards(page: 1, name: nil, setCode: nil, type: nil, orderParameter: nil, completion: { result, _ in

                switch result {
                case let .success(cardsResponse):
                    cards = cardsResponse
                case .failure:
                    cards = []
                }

            })

            let router = CardDetailRouter(cards: cards, selectedCard: cards.last!)

            sut = router.presenter.view
            UIApplication.shared.keyWindow?.rootViewController = sut
        }

        context("when it is initialized") {
            it("should match view with snapshot") {
                self.tester().waitForAnimationsToFinish()
                expect(sut) == snapshot()
            }
        }

        context("when it finished scrooling to selected card") {
            it("has selectedCard equal to the last card on the array") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.presenter.interactor.selectedCard).to(equal(cards.last))
            }
        }

        context("when the selectedCard is changed to the first card") {
            beforeEach {
                sut.presenter.interactor.changeSelectedCard(index: 0)
                sut.presenter.scroolToSelectedCard()
            }

            it("has selectedCard equal to the first card on the array") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.presenter.interactor.selectedCard).to(equal(cards.first))
            }

            it("should match view with snapshot") {
                self.tester().waitForAnimationsToFinish()
                expect(sut) == snapshot()
            }
        }
    }
}
