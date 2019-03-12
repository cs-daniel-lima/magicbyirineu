import UIKit

class FavoriteButton: UIButton {
    var isFavorite: Bool {
        didSet {
            setup(status: isFavorite)
        }
    }

    init(status: Bool) {
        isFavorite = status
        super.init(frame: .zero)
        setup(status: isFavorite)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(status: Bool) {
        setupAppearance()
        switch status {
        case true:
            setTitle("remove card from deck", for: .normal)
        case false:
            setTitle("add card to deck", for: .normal)
        }
    }

    private func setupAppearance() {
        backgroundColor = UIColor.clear
        titleLabel?.font = UIFont.sfProDisplay(size: 16, weight: .bold)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }

    public func setFavorite(isFavorite: Bool) {
        switch isFavorite {
        case true:
            self.isFavorite = true
        case false:
            self.isFavorite = false
        }
    }
}
