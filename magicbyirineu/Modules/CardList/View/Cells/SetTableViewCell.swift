//
//  SetTableViewCell.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class SetTableViewCell: UITableViewCell {
    
    var collectionViewDelegate: CategoriesCollectionViewDelegate!
    var collectionViewDataSource: CategoriesCollectionViewDataSource!
    
    lazy var setTitleLabel: UILabel = {
        var view = UILabel(frame: .zero)
        view.textColor = UIColor.lightGray
        view.font = UIFont(name:"SFProDisplay-Bold", size: 16.0)
        view.text = "Test"
        return view
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
       var view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
       view.backgroundColor = UIColor.clear
        return view
    }()

    func setupCell() {
        setupView()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCollectionView(){
        
        self.collectionViewDataSource = CategoriesCollectionViewDataSource.init(collectionView: self.categoryCollectionView)
        self.collectionViewDelegate = CategoriesCollectionViewDelegate()

        self.categoryCollectionView.delegate = collectionViewDelegate
        self.categoryCollectionView.dataSource = collectionViewDataSource
        
        guard let flowLayout = self.categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            print("Error")
            return
        }
        flowLayout.itemSize = CGSize(width: 85, height: 118)
        flowLayout.sectionInset.bottom = 16
        flowLayout.sectionInset.top = 16
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.right = 16
        
    }
    
}

extension SetTableViewCell: CodeView{
    
    func buildViewHierarchy() {
        self.contentView.addSubview(setTitleLabel)
        self.contentView.addSubview(categoryCollectionView)
    }
    
    func setupConstraints() {
        setTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        categoryCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(25)
            make.left.bottom.right.equalToSuperview()
            
        }
    }
    
    func additionalSetup() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    
}
