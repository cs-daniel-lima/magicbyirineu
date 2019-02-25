//
//  SubSectionCollectionViewCell.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class SubSectionCollectionViewCell: UICollectionViewCell {
    
    var label:UILabel
    
    override init(frame: CGRect) {
        self.label = UILabel(frame: .zero)
        
        super.init(frame:frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.label = UILabel(frame: .zero)
        
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    private func setup() {
        self.addSubview(self.label)
        
        self.label.snp.makeConstraints { (make) in
            make.left.top.trailing.bottom.equalToSuperview()
        }
    }
}
