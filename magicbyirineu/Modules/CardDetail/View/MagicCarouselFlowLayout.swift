import UIKit

class MagicCarouselFlowLayout: UICollectionViewFlowLayout {
    private let lateralItemsScale: CGFloat = 0.73
    let visibleSpacingOffset: CGFloat

    required init(visibleOffset: CGFloat) {
        visibleSpacingOffset = visibleOffset
        super.init()
        setupDefaultLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func prepare() {
        super.prepare()
        setupCollectionViewLayout()
    }

    private func setupDefaultLayout() {
        scrollDirection = .horizontal
        minimumInteritemSpacing = 16
        itemSize = CGSize(width: 190, height: 264)
    }

    fileprivate func setupCollectionViewLayout() {
        guard let collectionView = self.collectionView else { return }

        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        let size = collectionView.bounds.size

        let yInset = (size.height - itemSize.height) / 2
        let xInset = (size.width - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let lateralSize = itemSize.width
        let scaledItemOffset = (lateralSize - lateralSize * lateralItemsScale) / 2

        let fullSizeSideItemOverlap = visibleSpacingOffset + scaledItemOffset
        minimumLineSpacing = xInset - fullSizeSideItemOverlap
    }

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = copyDefaultLayout(attributes: super.layoutAttributesForElements(in: rect)) else {
            return nil
        }

        return attributes.map({ self.configLayoutAttribute(attributes: $0) })
    }

    override func shouldInvalidateLayout(forBoundsChange _: CGRect) -> Bool {
        return true
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity _: CGPoint) -> CGPoint {
        guard let collectionView = collectionView, !collectionView.isPagingEnabled,
            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }

        let centralPosition = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.x + centralPosition

        let closestItemAttribute = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()

        let targetContentOffset = CGPoint(x: floor(closestItemAttribute.center.x - centralPosition), y: proposedContentOffset.y)

        return targetContentOffset
    }

    func configLayoutAttribute(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }

        let center = collectionView.frame.size.width / 2
        let offset = collectionView.contentOffset.x
        let calculatedCenter = attributes.center.x - offset

        let maxDistance = itemSize.width + minimumLineSpacing
        let distance = min(abs(center - calculatedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance

        let scale = ratio * (1 - lateralItemsScale) + lateralItemsScale
        let positionChange = (1 - ratio) * lateralItemsScale

        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(scale * 10)

        attributes.center.y = attributes.center.y + positionChange

        return attributes
    }

    func copyDefaultLayout(attributes: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
        return attributes?.map { $0.copy() } as? [UICollectionViewLayoutAttributes]
    }
}
