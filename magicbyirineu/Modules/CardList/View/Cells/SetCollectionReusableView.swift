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
    
    let label: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.white
        view.font = UIFont(name:"SFProDisplay-Bold", size: 36.0)
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        return blurEffectView
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
        self.addSubview(self.blurEffectView)
        self.addSubview(self.label)
    }
    
    func setupConstraints() {
        self.label.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(16)
        }
        
        self.blurEffectView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.backgroundColor = .clear
    }
}
