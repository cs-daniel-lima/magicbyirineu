//
//  MagicSearchBarSpec.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Nimble_Snapshots

@testable import magicbyirineu

class MagicSearchBarSpec:QuickSpec{
    
    override func spec() {
        
        var sut:MagicSearchBar!
        var viewController:UIViewController!
        
        beforeEach {
            viewController = UIViewController()
            
            sut = MagicSearchBar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 56), font: UIFont(name: "SFProDisplay-Bold", size: 14)!)
            
            UIApplication.shared.keyWindow?.rootViewController = viewController
            viewController.view.addSubview(sut)
            sut.additionalSetupAfterDisplay()
        }
        
        context("when it is initialized"){
            it("should view match with snapshot when displayed in a UIViewController") {
                
                //expect(sut) == recordSnapshot("CLSearchBarSpec")
                expect(sut) == snapshot("CLSearchBarSpec")
                
            }
        }
        
    }
}

