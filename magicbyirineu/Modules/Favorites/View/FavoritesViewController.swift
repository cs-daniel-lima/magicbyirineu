import UIKit

class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenter!
    let screen = CardListView()

    required init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func set(status: Status) {
        switch status {
        case .normal:
            screen.emptySearchLabel.isHidden = true
            screen.emptySearchLabel.text = ""
            screen.set(status: .normal)
        case .empty:
            screen.emptySearchLabel.isHidden = false
            screen.emptySearchLabel.text = "You don't have any cards in your deck."
            screen.set(status: .empty)
        case .searching:
            screen.emptySearchLabel.isHidden = false
            screen.emptySearchLabel.text = "You don't have any cards in your deck."
            screen.set(status: .searching)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.searchBar.additionalSetupAfterDisplay()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
