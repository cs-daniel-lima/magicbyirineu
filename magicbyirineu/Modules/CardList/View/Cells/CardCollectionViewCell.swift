//
//  CardCollectionViewCell.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var cardHeight:CGFloat?
    
    let shadowView: RoundedView = {
        var view = RoundedView(frame: .zero)
        view.setupAsShadowView()
        return view
    }()
    let roundedView: RoundedView = {
        var view = RoundedView(frame: .zero)
        view.setupAsRoundedView()
        return view
    }()
    let backgroundImage: UIImageView = {
        var view = UIImageView(image: nil, highlightedImage: nil)
        view.backgroundColor = UIColor.clear
        view.image = UIImage(named: "testCard")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    func setupCell(cardHeight:CGFloat){
        self.cardHeight = cardHeight
        setupView()
    }
    
}

extension CardCollectionViewCell: CodeView{
    func buildViewHierarchy() {
        self.addSubview(shadowView)
        self.addSubview(roundedView)
        self.roundedView.addSubview(backgroundImage)
    }
    
    func setupConstraints() {
        
        guard let height = cardHeight else {
            return
        }
        
        shadowView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }
        roundedView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((85 / 118) * height)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func additionalSetup() {
        self.contentView.backgroundColor = UIColor.clear
    }
    
    
}
