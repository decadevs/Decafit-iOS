//
//  DecafitTests.swift
//  DecafitTests
//
//  Created by Decagon on 11/07/2022.
//

import XCTest
@testable import Decafit

class DecafitTests: XCTestCase {
    func testSignup() {
        let sut = User(
            fullName: "Jose Mori",
            email: "jose@gmail.com",
            phoneNumber: "09088876543",
            password: "090909"
        )
        XCTAssertNotNil(sut)
     }
}
