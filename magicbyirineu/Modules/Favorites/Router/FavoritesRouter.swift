import Foundation

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init() {
        let viewController = FavoritesViewController(title: "Favorites")

        let cardRepository = DatabaseCardsService()
        let cardSetRepository = DatabaseSetsService()
        let typeRepository = DatabaseTypesService()

        let fetchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        let searchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)

        let fetchOrganizer = CardOrganizer()
        let searchOrganizer = CardOrganizer()

        let interactor = CardListInteractor(fetchLoader: fetchLoader, searchLoad: searchLoader, fetchCardOrganizer: fetchOrganizer, searchCardOrganizer: searchOrganizer)

        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }

    func goToCardDetail(cards: [Card], selectedCard: Card, sets: [CardSet]) {
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard, sets: sets)
        presenter.view.present(router.presenter.view, animated: true, completion: nil)
    }
}
