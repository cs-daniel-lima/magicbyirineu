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
            screen.set(status: .normal, sender: self)
        case .empty:
            screen.emptySearchLabel.isHidden = false
            screen.set(status: .empty, sender: self)
        case .searching:
            screen.emptySearchLabel.isHidden = false
            screen.set(status: .searching, sender: self)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.searchBar.additionalSetupAfterDisplay()

        presenter.update()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
