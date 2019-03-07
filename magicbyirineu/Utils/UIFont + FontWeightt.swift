//
//  CustomFont.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 07/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

extension UIFont{
    
    enum FontWeight: String{
        case bold = "Bold"
        case regular = "Regular"
    }
    
    class func sfProDisplay(size: CGFloat, weight: FontWeight) -> UIFont{
        let fontName = "SFProDisplay-" + weight.rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont()
        }
        return font
    }
    
}
