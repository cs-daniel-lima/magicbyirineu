//
//  MagicAPITest.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import XCTest
@testable import magicbyirineu

class MagicAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetSetsRequest() {
        XCTAssert(GetSets.Response.self ==  ResponseSets.self, "Response condizente com o Request")
    }
    
    func testGetCardsRequest() {
        XCTAssert(GetCards.Response.self ==  ResponseCards.self, "Response condizente com o Request")
    }
}
