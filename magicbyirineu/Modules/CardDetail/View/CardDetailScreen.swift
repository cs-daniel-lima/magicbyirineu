//
//  CardDetailScreen.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class CardDetailScreen: UIView {
    
    let favoriteButton: FavoriteButton = {
        var view = FavoriteButton(status: false)
        return view
    }()
    
    let dismissButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "close"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let cardImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    let cardName: UILabel = {
       var view = UILabel()
       view.font = UIFont.sfProDisplay(size: 26, weight: .bold)
       view.numberOfLines = 2
       view.textAlignment = .center
       view.textColor = UIColor.white
       return view
    }()
    
    let backgroundImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "fundo")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardDetailScreen: CodeView{
    
    func buildViewHierarchy() {
        self.addSubview(backgroundImage)
        self.cardImage.addSubview(cardName)
        self.addSubview(cardImage)
        self.addSubview(dismissButton)
        self.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        self.backgroundImage.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        self.cardImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4647)
            make.width.equalTo(self.cardImage.snp.height).multipliedBy(0.71)
        }
        
        self.dismissButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(8)
            make.height.width.equalTo(44)
        }
        
        self.cardName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        self.favoriteButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.0845)
        }
        
    }
    
    func additionalSetup() {
        self.backgroundColor = UIColor.clear
    }
    
}

