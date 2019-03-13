import UIKit

enum Status {
    case normal
    case empty
}

enum SearchStatus {
    case querying
    case normal
}

class CardListViewController: MagicViewController {
    var presenter: CardListPresenter!
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
            screen.set(status: .normal)
        case .empty:
            if isQuering == false {
                screen.emptySearchLabel.isHidden = false
            }
            screen.set(status: .empty)
        }
    }

    func set(searchStatus: SearchStatus) {
        switch searchStatus {
        case .normal:
            isQuering = false
            screen.set(searchStatus: .normal)
        case .querying:
            isQuering = true
            screen.set(searchStatus: .querying)
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
