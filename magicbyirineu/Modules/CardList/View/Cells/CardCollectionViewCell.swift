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
    
    let shadowView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        
        return view
    }()
    let roundedView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
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
