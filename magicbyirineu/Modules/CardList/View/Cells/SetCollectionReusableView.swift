//
//  SetCollectionReusableView.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class SetCollectionReusableView:  UICollectionReusableView {
    
    lazy var label: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.lightGray
        view.font = UIFont(name:"SFProDisplay-Bold", size: 16.0)
        view.text = "Test"
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


extension SetCollectionReusableView: CodeView{
    
    func buildViewHierarchy() {
        self.addSubview(self.label)
    }
    
    func setupConstraints() {
        self.label.snp.makeConstraints { (make) in
            make.left.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.backgroundColor = .clear
    }
}
