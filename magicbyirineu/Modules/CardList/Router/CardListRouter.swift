import Foundation

class CardListRouter {
    var presenter: CardListPresenter!

    init() {
        let viewController = CardListViewController(title: "Cards")
        let interactor = CardListInteractor(cardRepository: CardAPIClient(),
                                            cardSetRepository: CardSetAPIClient(),
                                            typeRepository: TypeAPIClient())
        presenter = CardListPresenter(router: self, interactor: interactor, view: viewController)
    }

    func goToCardDetail(cards: [Card], selectedCard: Card) {
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard)
        presenter.view.present(router.presenter.view, animated: true, completion: nil)
    }
}
