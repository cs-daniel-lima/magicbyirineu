import Foundation

class CardDetailRouter {
    let presenter: CardDetailPresenter

    init(cards: [Card], selectedCard: Card) {
        let viewController = CardDetailViewController()
        let interactor = CardDetailInteractor(cards: cards, selectedCard: selectedCard)

        presenter = CardDetailPresenter(interactor: interactor, view: viewController)

        setupPresenter()
    }

    func setupPresenter() {
        presenter.router = self
    }
}
