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
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.wasNumberOfSectionCalled = true
        return super.numberOfSections(in: collectionView)
    }
    
}

