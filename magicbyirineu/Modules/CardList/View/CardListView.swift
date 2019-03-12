import UIKit

class CardListView: UIView {
    let emptySearchLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.sfProDisplay(size: 22, weight: .bold)
        view.text = "We couldn't find the card you were looking for."
        view.textAlignment = .center
        view.numberOfLines = 2
        view.isHidden = true
        view.textColor = UIColor.white
        return view
    }()

    let backgroundImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()

    let searchBar: MagicSearchBar = {
        let view = MagicSearchBar(frame: .zero, font: UIFont.sfProDisplay(size: 14, weight: .bold))
        return view
    }()

    let collectionView: UICollectionView = {
        let layout = MagicFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        view.backgroundView?.backgroundColor = UIColor.clear
        view.backgroundColor = .clear

        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardListView: CodeView {
    func buildViewHierarchy() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(emptySearchLabel)
        addSubview(collectionView)
        addSubview(searchBar)
    }

    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(0)
        }
        emptySearchLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(44)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }

    func additionalSetup() {
        backgroundImageView.image = UIImage(named: "fundo")
    }
}
