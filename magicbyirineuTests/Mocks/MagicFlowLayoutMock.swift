//
//  MagicFlowLayoutMock.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 28/02/2019.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

@testable import magicbyirineu

class MagicFlowLayoutMock: MagicFlowLayout {
    
    var alignWasCalled = false
    var layoutAttributesForElementsWasCalled = false
    var layoutAttributesForItemWasCalled = false
    var getCollectionWidthWasCalled = false
    
    override init(){
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        layoutAttributesForElementsWasCalled = true
        
        let layoutAttributesList = super.layoutAttributesForElements(in: rect)
        
        return layoutAttributesList
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        layoutAttributesForItemWasCalled = true
        
        let attributes = super.layoutAttributesForItem(at: indexPath)
        
        return attributes
        
    }
    
    override func align(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        alignWasCalled = true
        super.align(layoutAttributes: layoutAttributes)
        
    }
    
    override func getCollectionWidth() -> CGFloat {
        
        getCollectionWidthWasCalled = true
        return super.getCollectionWidth()
        
    }
    
    
}
