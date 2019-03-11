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
    
    let dismissButton: UIButton = {
        var view = UIButton()
        view.setImage(UIImage(named: "close"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let backgroundImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "fundo")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let collectionView: UICollectionView = {
        
        let layout = MagicCarouselFlowLayout(visibleOffset: 64)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        view.backgroundView?.backgroundColor = UIColor.clear
        view.backgroundColor = .clear
        view.isPagingEnabled = false
        view.decelerationRate = UIScrollView.DecelerationRate.fast
        
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
        self.addSubview(collectionView)
        self.addSubview(dismissButton)
    }
    
    func setupConstraints() {
        self.backgroundImage.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        self.dismissButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(8)
            make.height.width.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
        
    }
    
    func additionalSetup() {
        self.backgroundColor = UIColor.clear
    }
    
    
}

