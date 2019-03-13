import UIKit

enum Status {
    case normal
    case empty
}

class CardListViewController: MagicViewController {
    var presenter: CardListPresenter!
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
        case .empty:
            screen.emptySearchLabel.isHidden = false
            screen.emptySearchLabel.text = "We couldn't find the card you were looking for."
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
