import Foundation

class CardDetailRouter {
    let presenter: CardDetailPresenter

    init(cards: [Card], selectedCard: Card, sets: [CardSet]) {
        let viewController = CardDetailViewController()
        let interactor = CardDetailInteractor(cards: cards, selectedCard: selectedCard, sets: sets)

        presenter = CardDetailPresenter(interactor: interactor, view: viewController)

        setupPresenter()
    }

    func setupPresenter() {
        presenter.router = self
    }
}
