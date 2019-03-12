import UIKit

@testable import magicbyirineu

class MagicCarouselFlowLayoutMock: MagicCarouselFlowLayout {
    var layoutAttributesForElementsWasCalled = false
    var configLayoutAttributeWassCalled = false

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributesForElementsWasCalled = true

        let layoutAttributesList = super.layoutAttributesForElements(in: rect)

        return layoutAttributesList
    }

    override func configLayoutAttribute(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        configLayoutAttributeWassCalled = true

        return super.configLayoutAttribute(attributes: attributes)
    }
}
