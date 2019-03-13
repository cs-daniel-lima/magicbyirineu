import Reusable
import SnapKit
import UIKit

class SubSectionCollectionViewCell: UICollectionViewCell, Reusable {
    let label: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.white
        view.alpha = 0.7
        view.font = UIFont.sfProDisplay(size: 14, weight: .bold)
        return view
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

extension SubSectionCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(label)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(16)
        }
    }

    func additionalSetup() {
        backgroundColor = .clear
    }
}
