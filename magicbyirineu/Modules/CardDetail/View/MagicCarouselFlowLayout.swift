//
//  MagicCarouselFlowLayout.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicCarouselFlowLayout: UICollectionViewFlowLayout {
    
    let lateralItemsScale:CGFloat = 0.7
    
    override init() {
        super.init()
        setupDefaultLayout()
    }
    
    override open func prepare() {
        super.prepare()
        setupCollectionViewLayout()
    }
    
    private func setupDefaultLayout(){
        
        scrollDirection = .horizontal
        minimumInteritemSpacing = 16
        itemSize = CGSize(width: 190, height: 264)
        
    }
    
    fileprivate func setupCollectionViewLayout(){
        
        guard let collectionView = self.collectionView else { return }
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let size = collectionView.bounds.size
        
        let yInset = (size.height - self.itemSize.height) / 2
        let xInset = (size.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        /*
        let lateralSize = self.itemSize.width
        let scaledItemOffset =  (lateralSize - lateralSize*self.lateralItemsScale) / 2
        
        let visibleOffset:CGFloat = 16
        let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
        self.minimumLineSpacing = xInset - fullSizeSideItemOverlap
        */
        
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = copyDefaultLayout(attributes: super.layoutAttributesForElements(in: rect)) else{
            return nil
        }
        
        return attributes.map({ self.configLayoutAttribute(attributes: $0) })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return true
        
    }
    
    func configLayoutAttribute(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let center = collectionView.frame.size.width/2
        let offset = collectionView.contentOffset.x
        let calculatedCenter = attributes.center.x - offset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(center - calculatedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        let scale = ratio * (1 - self.lateralItemsScale) + self.lateralItemsScale
        let positionChange = (1 - ratio) * self.lateralItemsScale
        
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(scale * 10)
        
        attributes.center.y = attributes.center.y + positionChange
        
        return attributes
        
    }
    
    func copyDefaultLayout(attributes: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]?{
        return attributes?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
    }
    
    
}
