import Foundation

class CardListRouter {
    var presenter: CardListPresenter!

    init() {
        let viewController = CardListViewController(title: "Cards")

        let cardRepository = CardAPIClient()
        let cardSetRepository = CardSetAPIClient()
        let typeRepository = TypeAPIClient()

        let fetchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        let searchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)

        let fetchOrganizer = CardOrganizer()
        let searchOrganizer = CardOrganizer()

        let interactor = CardListInteractor(fetchLoader: fetchLoader, searchLoad: searchLoader, fetchCardOrganizer: fetchOrganizer, searchCardOrganizer: searchOrganizer)
        presenter = CardListPresenter(router: self, interactor: interactor, view: viewController)
    }

    func goToCardDetail(cards: [Card], selectedCard: Card) {
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard)
        presenter.view.present(router.presenter.view, animated: true, completion: nil)
    }
}
