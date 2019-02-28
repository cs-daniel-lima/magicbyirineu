//
//  RoundedView.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 27/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

enum ViewType {
    case rounded
    case roundedAndShaded
}

class RoundedView: UIView{
    
    var type: ViewType
    
    init(type: ViewType) {
        self.type = type
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        switch self.type {
        case .rounded:
            
            self.layer.cornerRadius = 5
            self.backgroundColor = UIColor.clear
            self.clipsToBounds = true
            
        case .roundedAndShaded:
            
            self.layer.cornerRadius = 5
            self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.1
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 1
            
        }
        
    }
    
}

