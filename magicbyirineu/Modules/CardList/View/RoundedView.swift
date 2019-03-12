import UIKit

enum ViewType {
    case rounded
    case roundedAndShaded
}

class RoundedView: UIView {
    var type: ViewType

    init(type: ViewType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        switch type {
        case .rounded:

            layer.cornerRadius = 5
            backgroundColor = UIColor.clear
            clipsToBounds = true

        case .roundedAndShaded:

            layer.cornerRadius = 5
            backgroundColor = UIColor.white.withAlphaComponent(0.3)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 1
        }
    }
}
