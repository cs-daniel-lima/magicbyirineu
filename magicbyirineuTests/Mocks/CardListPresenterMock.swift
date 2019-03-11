//
//  CardListPresenterMock.swift
//  magicbyirineuTests
//
//  Created by andre.antonio.filho on 01/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation
import UIKit

@testable import magicbyirineu

public class CardListPresenterMock: CardListPresenter{
    
    var wasNumberOfSectionCalled = false
    var wasCellForItemAtCalled = false
    var wasViewForSupplementaryElementOfKindCalled = true
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.wasNumberOfSectionCalled = true
        return super.numberOfSections(in: collectionView)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.wasCellForItemAtCalled = true
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.wasViewForSupplementaryElementOfKindCalled = true
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
}

