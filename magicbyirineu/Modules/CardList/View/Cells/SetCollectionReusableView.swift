import Reusable
import SnapKit
import UIKit

class SetCollectionReusableView: UICollectionReusableView, Reusable {
    let label: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.white
        view.font = UIFont.sfProDisplay(size: 36, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        return view
    }()

    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        return blurEffectView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }
}

extension SetCollectionReusableView: CodeView {
    func buildViewHierarchy() {
        addSubview(blurEffectView)
        addSubview(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }

        blurEffectView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    func additionalSetup() {
        backgroundColor = .clear
    }
}
