//
//  RoundedView.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 27/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class RoundedView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAsShadowView(){
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        
    }
    
    func setupAsRoundedView(){
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
    }
    

    
}

