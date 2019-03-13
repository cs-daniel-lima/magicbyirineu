import Foundation
import UIKit

@testable import magicbyirineu

public class FavoritesPresenterMock: FavoritesPresenter {
    var wasNumberOfSectionCalled = false
    var wasCellForItemAtCalled = false

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        wasNumberOfSectionCalled = true
        return super.numberOfSections(in: collectionView)
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        wasCellForItemAtCalled = true
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}
