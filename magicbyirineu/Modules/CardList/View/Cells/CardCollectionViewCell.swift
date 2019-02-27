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
    
    let shadowView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 4
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        
        return view
    }()
    let roundedView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    let backgroundImage: UIImageView = {
        var view = UIImageView(image: nil, highlightedImage: nil)
        view.backgroundColor = UIColor.brown
        view.image = UIImage(named: "testCard")
        return view
    }()
    
    func setupCell(){
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
        
        shadowView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        roundedView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
    }
    
    func additionalSetup() {
        self.contentView.backgroundColor = UIColor.clear
    }
    
    
}
