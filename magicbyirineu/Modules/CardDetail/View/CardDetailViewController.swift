import Kingfisher
import UIKit

class CardDetailViewController: MagicViewController {
    var presenter: CardDetailPresenter!
    var screen = CardDetailScreen()

    override func loadView() {
        super.loadView()

        view = screen
        screen.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        screen.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if checkForFavorite(card: presenter.interactor.selectedCard) {
            screen.favoriteButton.isFavorite = true
        } else {
            screen.favoriteButton.isFavorite = false
        }
        presenter.scroolToSelectedCard()
    }

    func checkForFavorite(card _: Card) -> Bool {
        var returnValue: Bool

        if presenter.interactor.dbManager.isfavorited(card: presenter.interactor.selectedCard) == true {
            returnValue = true
        } else {
            returnValue = false
        }
        return returnValue
    }

    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func favoriteButtonTapped() {
        switch screen.favoriteButton.isFavorite {
        case true:
            screen.favoriteButton.isFavorite = false
            presenter.interactor.removeCardFromFavorite()
        case false:
            screen.favoriteButton.isFavorite = true
            presenter.interactor.saveCardAsFavorite()
        }
    }
}
