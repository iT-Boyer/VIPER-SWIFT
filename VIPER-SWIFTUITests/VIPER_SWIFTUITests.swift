//
//  VIPER_SWIFTUITests.swift
//  VIPER-SWIFTUITests
//
//  Created by jhmac on 2020/6/10.
//  Copyright © 2020 iTBoyer. All rights reserved.
//

import XCTest
@testable import VIPER_SWIFT

class VIPER_SWIFTUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    func testEmptyUserNameAndPassword() {
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        
        let alerts = app.alerts
        let label = app.alerts.staticTexts["Empty username/password"]
        
        let alertCount = NSPredicate(format: "count == 1")
        let labelExist = NSPredicate(format: "exists == 1")
        
        expectation(for: alertCount, evaluatedWith: alerts, handler: nil)
        expectation(for: labelExist, evaluatedWith: label, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginSuccessfully() {
        
        let userName = "onevcat"
        let password = "123"
        
        let app = XCUIApplication()
        
        let userNameTextField = app.textFields["username"]
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        
        let passwordTextField = app.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)

        app.buttons["Login"].tap()

        let navTitle = app.navigationBars[userName].staticTexts[userName]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: navTitle, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSwitchAndCount() {
        let userName = "onevcat"
        let password = "123"
        
        let app = XCUIApplication()
        
        let userNameTextField = app.textFields["username"]
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        
        let passwordTextField = app.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["Login"].tap()

        sleep(3)
        
        let switcher = app.switches["checkin"]
        let l = app.staticTexts["countLabel"]

        switcher.tap()
        XCTAssertEqual(l.label, "1", "Count label should be 1 after clicking check in.")
        
        switcher.tap()
        XCTAssertEqual(l.label, "0", "And 0 after clicking again.")
        
    }
}
