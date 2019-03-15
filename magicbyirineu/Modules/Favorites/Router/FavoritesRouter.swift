import Foundation

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init() {
        let viewController = FavoritesViewController(title: "Favorites")
        
        
        
        //presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }

    func goToCardDetail(cards: [Card], selectedCard: Card, sets: [CardSet]) {
        let router = CardDetailRouter(cards: cards, selectedCard: selectedCard, sets: sets)
        presenter.view.present(router.presenter.view, animated: true, completion: nil)
    }
}
