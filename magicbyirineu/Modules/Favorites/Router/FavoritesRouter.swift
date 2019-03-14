import Foundation

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init() {
        let viewController = FavoritesViewController(title: "Favorites")
        let interactor = CardListInteractor(cardRepository: DatabaseCardsService(),
                                            cardSetRepository: DatabaseSetsService(),
                                            typeRepository: DatabaseTypesService())

        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }
}
