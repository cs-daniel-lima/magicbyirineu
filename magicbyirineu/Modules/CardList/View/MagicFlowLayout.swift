//
//  MagicFlowLayout.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupDefaultLayout()
    }
    
    func setupDefaultLayout(){
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 16
        sectionHeadersPinToVisibleBounds = true
        
        headerReferenceSize = CGSize(width: 200, height: 41)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
