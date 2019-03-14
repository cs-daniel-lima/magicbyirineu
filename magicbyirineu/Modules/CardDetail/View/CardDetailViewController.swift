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
        presenter.scroolToSelectedCard()
    }

    @objc func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func favoriteButtonTapped() {
        screen.switchButtonStatus()
    }
}
