//
//  MagicCarouselFlowLayoutMock.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 11/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

@testable import magicbyirineu

class MagicCarouselFlowLayoutMock: MagicCarouselFlowLayout {
    
    var layoutAttributesForElementsWasCalled = false
    var targetContentOffsetWasCalled = false
    var configLayoutAttributeWassCalled = false
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        layoutAttributesForElementsWasCalled = true
        
        let layoutAttributesList = super.layoutAttributesForElements(in: rect)
        
        return layoutAttributesList
        
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        targetContentOffsetWasCalled = true
        
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
    }
    
    override func configLayoutAttribute(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        configLayoutAttributeWassCalled = true
        
        return super.configLayoutAttribute(attributes: attributes)
        
    }
    
}
