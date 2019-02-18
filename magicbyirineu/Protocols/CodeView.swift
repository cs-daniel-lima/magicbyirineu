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
    func buildViewHierarchy()
    func setupConstraints()
    func additionalSetup()
}

extension CodeView{
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        additionalSetup()
    }
}
