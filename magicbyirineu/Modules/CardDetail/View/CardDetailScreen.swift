import SnapKit
import UIKit

class CardDetailScreen: UIView {
    let favoriteButton: FavoriteButton = {
        var view = FavoriteButton(status: false)
        return view
    }()

    let dismissButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "close"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()

    let backgroundImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "fundo")
        view.contentMode = .scaleAspectFill
        return view
    }()

    let collectionView: UICollectionView = {
        let layout = MagicCarouselFlowLayout(visibleOffset: 64)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        view.backgroundView?.backgroundColor = UIColor.clear
        view.backgroundColor = .clear
        view.isPagingEnabled = false
        view.decelerationRate = UIScrollView.DecelerationRate.fast

        return view
    }()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func switchButtonStatus() {
        switch favoriteButton.isFavorite {
        case true:
            favoriteButton.isFavorite = false
        case false:
            favoriteButton.isFavorite = true
        }
    }
}

extension CardDetailScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(collectionView)
        addSubview(dismissButton)
        addSubview(favoriteButton)
    }

    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        dismissButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(8)
            make.height.width.equalTo(44)
        }

        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }

        favoriteButton.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.0845)
        }
    }

    func additionalSetup() {
        backgroundColor = UIColor.clear
    }
}
