//
//  KIFExtensions.swift
//  magicbyirineuTests
//
//  Created by daniel.da.cunha.lima on 28/02/2019.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import KIF

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        KIFEnableAccessibility()
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        KIFEnableAccessibility()
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        KIFEnableAccessibility()
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        KIFEnableAccessibility()
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
