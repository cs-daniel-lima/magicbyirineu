import Foundation
import SnapKit

protocol CodeView {
    func additionalSetup()
    func buildViewHierarchy()
    func setupConstraints()
}

extension CodeView {
    func setupView() {
        additionalSetup()
        buildViewHierarchy()
        setupConstraints()
    }
}
