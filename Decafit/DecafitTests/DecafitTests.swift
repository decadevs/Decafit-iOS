//
//  DecafitTests.swift
//  DecafitTests
//
//  Created by Decagon on 11/07/2022.
//

import XCTest
@testable import Decafit

class DecafitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let name = "dev"
        let age = 18
        XCTAssert(name=="dev", "Your name is wrong!")
        XCTAssert(age==18, "You must be underage")
    }

}
