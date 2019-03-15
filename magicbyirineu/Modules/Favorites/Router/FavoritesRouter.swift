import Foundation
import Realm
import RealmSwift

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init(realm: Realm) {
        let databaseManager = DatabaseManager(realm: realm)

        let viewController = FavoritesViewController(title: "Favorites")

        let interactor = FavoritesInteractor(databaseManager: databaseManager)

        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }

    func goToCardDetail(cards: [Card], selectedCard: Card, sets: [CardSet]) {
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard, sets: sets)
        presenter.view.present(router.presenter.view, animated: true, completion: nil)
    }
}
