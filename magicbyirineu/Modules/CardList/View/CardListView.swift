//
//  CardListView.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

final class CardListView : UIView{
    
    lazy var backgroundImageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var searchBar:MagicSearchBar = {
        let view = MagicSearchBar(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardListView :CodeView{
    
    func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(searchBar)
    }
    
    func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(44)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
    }
    
    func additionalSetup() {
        
        backgroundImageView.image = UIImage(named: "fundo")
        
    }
    
}

