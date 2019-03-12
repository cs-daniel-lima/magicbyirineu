import UIKit

class MagicFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupDefaultLayout()
    }

    private func setupDefaultLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 16

        sectionHeadersPinToVisibleBounds = true
        headerReferenceSize = CGSize(width: 200, height: 41)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesList = copyDefaultLayout(attributes: super.layoutAttributesForElements(in: rect)) else {
            return nil
        }

        for layoutAttributes in layoutAttributesList {
            align(layoutAttributes: layoutAttributes)
        }

        return layoutAttributesList
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }

        return attributes
    }

    func getCollectionWidth() -> CGFloat {
        if let width = collectionView?.frame.size.width {
            return width
        } else {
            return UIScreen.main.bounds.size.width
        }
    }

    func copyDefaultLayout(attributes: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
        return attributes?.map { $0.copy() } as? [UICollectionViewLayoutAttributes]
    }

    func align(layoutAttributes: UICollectionViewLayoutAttributes) {
        if layoutAttributes.representedElementCategory == .cell {
            let currentIndexPath = layoutAttributes.indexPath

            if let currentItemAttributes = layoutAttributesForItem(at: currentIndexPath) {
                currentItemAttributes.alignLeft(usingLayout: self, collectionWidth: getCollectionWidth())
                layoutAttributes.frame = currentItemAttributes.frame
            }
        }
    }
}
