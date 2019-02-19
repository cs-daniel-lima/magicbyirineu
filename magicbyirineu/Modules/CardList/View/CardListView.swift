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
    
    var setsTableView: UITableView = {
       let view = UITableView(frame: .zero)
       view.backgroundColor = UIColor.clear
       view.sectionHeaderHeight = 50
       view.sectionIndexBackgroundColor = UIColor.clear
       view.backgroundView?.backgroundColor = UIColor.clear
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
    }
    
    func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        setsTableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
        
    }
    
    func additionalSetup() {
        backgroundImageView.image = UIImage(named: "fundo")
    }
    
}

