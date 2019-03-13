import Foundation
import UIKit

@testable import magicbyirineu

public class CardListPresenterMock: CardListPresenter {
    var wasNumberOfSectionCalled = false
    var wasCellForItemAtCalled = false
    var wasViewForSupplementaryElementOfKindCalled = true

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        wasNumberOfSectionCalled = true
        return super.numberOfSections(in: collectionView)
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        wasCellForItemAtCalled = true
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }

    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        wasViewForSupplementaryElementOfKindCalled = true
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
