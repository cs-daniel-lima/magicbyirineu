//
//  SubSectionCollectionViewCell.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 25/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class SubSectionCollectionViewCell: UICollectionViewCell, Reusable {
    
     let label: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.white
        view.alpha = 0.7
        view.font = UIFont.sfProDisplay(size: 14, weight: .bold)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
}


extension SubSectionCollectionViewCell: CodeView{
    
    func buildViewHierarchy() {
        self.addSubview(self.label)
    }
    
    func setupConstraints() {
        self.label.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(16)
        }
    }
    
    func additionalSetup() {
        self.backgroundColor = .clear
    }
}
