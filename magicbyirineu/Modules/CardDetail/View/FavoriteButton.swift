//
//  FavoriteButton.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 12/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteButton: UIButton {
    
    var isFavorite: Bool

     init(status: Bool) {
        self.isFavorite = status
        super.init(frame: .zero)
        self.setup(status: self.isFavorite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(status: Bool){
        
        self.setupAppearance()
        switch status {
        case true:
            self.setTitle("remove card from deck", for: .normal)
        case false:
            self.setTitle("add card to deck", for: .normal)
        }
        
    }
    
    private func setupAppearance(){
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font = UIFont.sfProDisplay(size: 16, weight: .bold)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    
    public func setAsFavorite(){
        self.isFavorite = true
        self.setTitle("remove card from deck", for: .normal)
    }
    
    public func setAsNotFavorite(){
        self.isFavorite = false
        self.setTitle("add card to deck", for: .normal)
    }
    
}


