import UIKit

extension UICollectionViewLayoutAttributes {
    func alignLeft(usingLayout layout: MagicFlowLayout, collectionWidth: CGFloat) {
        if indexPath.item > 0 {
            let interItemSpacing = layout.minimumInteritemSpacing
            let previewsIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)

            if let previousItemAttributes = layout.layoutAttributesForItem(at: previewsIndexPath) {
                var xPosition = previousItemAttributes.frame.maxX + interItemSpacing
                if xPosition >= collectionWidth {
                    xPosition = 0
                }

                if frame.size.width == UIScreen.main.bounds.width {
                    xPosition = 0
                }

                frame.origin.x = xPosition
            }
        }
    }
}
