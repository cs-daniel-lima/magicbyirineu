import Reusable
import SnapKit
import UIKit

enum CardCollectionViewCellType {
    case homeScreenCell
    case detailScreenCell
}

class CardCollectionViewCell: UICollectionViewCell, Reusable {
    var cardHeight: CGFloat?

    var type: CardCollectionViewCellType? {
        didSet {
            setupCell()
        }
    }

    let cardTitle: UILabel = {
        var view = UILabel()
        view.font = UIFont.sfProDisplay(size: 14, weight: .bold)
        view.textAlignment = .center
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 1
        view.numberOfLines = 2
        view.textColor = UIColor.white
        return view
    }()

    let shadowView: RoundedView = {
        var view = RoundedView(type: .roundedAndShaded)
        return view
    }()

    let roundedView: RoundedView = {
        var view = RoundedView(type: .rounded)
        return view
    }()

    let backgroundImage: UIImageView = {
        var view = UIImageView(image: nil, highlightedImage: nil)
        view.backgroundColor = UIColor.clear
        view.image = UIImage(named: "testCard")
        view.contentMode = .scaleAspectFit
        return view
    }()

    func setupCell() {
        guard let currentType = type else {
            setupView()
            return
        }

        switch currentType {
        case .homeScreenCell:
            cardHeight = (118 / 320) * UIScreen.main.bounds.width
        case .detailScreenCell:
            cardHeight = 264
        }

        setupView()
    }
}

extension CardCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(shadowView)
        addSubview(roundedView)
        roundedView.addSubview(backgroundImage)
        backgroundImage.addSubview(cardTitle)
    }

    func setupConstraints() {
        guard let height = cardHeight else {
            return
        }

        shadowView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }
        roundedView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }

        cardTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
    }

    func additionalSetup() {
        contentView.backgroundColor = UIColor.clear
    }
}
