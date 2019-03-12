import Foundation

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init() {
        let viewController = FavoritesViewController(title: "Favorites")
        let interactor = FavoritesInteractor()

        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }
}
