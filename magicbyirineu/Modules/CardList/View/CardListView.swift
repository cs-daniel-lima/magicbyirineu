//
//  CardListView.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class CardListView : UIView{
    
    let backgroundImageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchBar:MagicSearchBar = {
        let view = MagicSearchBar(frame: .zero, font: UIFont(name: "SFProDisplay-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14))
        return view
    }()
    
    let setsTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.allowsSelection = false
        view.separatorColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        view.sectionHeaderHeight = 50
        view.sectionIndexBackgroundColor = UIColor.clear
        view.backgroundView?.backgroundColor = UIColor.clear
        
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 100
        
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
        addSubview(setsTableView)
        addSubview(searchBar)
    }
    
    func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        setsTableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
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

