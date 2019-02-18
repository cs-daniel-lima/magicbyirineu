//
//  CardListSearchBar.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class MagicSearchBar: UISearchBar {
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        let appFont = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        showsCancelButton = true
        tintColor = .white
        barTintColor = .white
        backgroundColor = .clear
        searchBarStyle = .minimal
        
        //Bar Button Item
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "cancel"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: appFont as Any,
            ], for: UIControl.State.normal)
        
        //Custom Border and background for the textfield
        let textField = value(forKey: "_searchField") as! UITextField
        
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.clear
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = UIColor.white
        
        textField.attributedPlaceholder =
            NSAttributedString(string: "search for cards", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        textField.font = appFont
        
    }
    
    func setupSearchBar(){
        
        let textField = value(forKey: "_searchField") as! UITextField
        
        //Left padding
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftView = leftPadding
        
        //Magnifier icon
        let icon = UIImageView(image: UIImage(named: "buscar"))
        textField.rightView = icon
        textField.rightViewMode = .always
        
    }
    
    
}
