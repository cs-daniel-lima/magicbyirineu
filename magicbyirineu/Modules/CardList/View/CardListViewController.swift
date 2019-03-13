import UIKit

enum Status {
    case searching
    case normal
    case empty
}

class CardListViewController: MagicViewController {
    var presenter: CardListPresenter?
    let screen = CardListView()

    var isQuering = false

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
            isQuering = false
            screen.set(status: .normal)
        case .empty:
            if isQuering == false {
                screen.emptySearchLabel.isHidden = false
            }
            screen.set(status: .empty)
        case .searching:
            isQuering = true
            screen.set(status: .searching)
        }
    }

    func switchActivityIndicator(status _: Status) {}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.searchBar.additionalSetupAfterDisplay()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
