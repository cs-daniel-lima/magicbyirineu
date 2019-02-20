//
//  CodeView.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView {
    func additionalSetup()
    func buildViewHierarchy()
    func setupConstraints()
}

extension CodeView{
    func setupView(){
        additionalSetup()
        buildViewHierarchy()
        setupConstraints()
    }
}
