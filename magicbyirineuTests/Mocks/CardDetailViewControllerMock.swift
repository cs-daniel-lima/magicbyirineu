import UIKit

@testable import magicbyirineu

class CardDetailViewControllerMock: CardDetailViewController {
    override func loadView() {
        super.loadView()
        view = screen
        screen.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc override func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
