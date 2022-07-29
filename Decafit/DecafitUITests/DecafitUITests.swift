//
//  DecafitUITests.swift
//  DecafitUITests
//
//  Created by Decagon on 11/07/2022.
//

import XCTest

class DecafitUITests: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func testLogin() {
        let app = XCUIApplication()
        app.launch()
        let emailField = app.textFields["Email address"]
        XCTAssertTrue(emailField.exists)
        emailField.tap()
        emailField.typeText("peter@gmail.io")
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("David123")
        let pointBelowPassword = passwordSecureTextField.coordinate(withNormalizedOffset: CGVector(dx: 1.9, dy: 0.5))
        pointBelowPassword.press(forDuration: 0.3)
        let button = app.buttons["Sign In"]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertFalse(button.exists)
    }
    func testToggleSignup() {
        let app = XCUIApplication()
        app.launch()
        let registerButton = app.buttons["Sign up"]
        XCTAssertTrue(registerButton.exists)
        registerButton.tap()
        let text = app.staticTexts["Don't have an account? "]
        XCTAssertTrue(text.exists)
        let loginButton = app.buttons["Sign in"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        let text1 = app.staticTexts["Already have an account? "]
        XCTAssertTrue(text1.exists)
    }
}
