//
//  CreateContactUITest.swift
//  Contacts-AppUITests
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import XCTest

class CreateContactUITest: XCTestCase {

    var app: XCUIApplication!
    
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()

        continueAfterFailure = false

        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateNewContact() {
        app.launch()
        
        app.navigationBars["Contact"].buttons["Add"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"First Name").children(matching: .textField).element.tap()
        
        let textField = tablesQuery.cells.containing(.staticText,
                                                     identifier:"Email").children(matching: .textField).element
        textField.tap()
        
        let textField2 = tablesQuery.cells.containing(.staticText,
                                                      identifier:"Last Name").children(matching: .textField).element
        textField2.tap()
        textField.swipeDown()
        textField.swipeUp()
        tablesQuery.cells.containing(.staticText,
                                     identifier:"Mobile").children(matching: .textField).element.tap()
        
        //tablesQuery.children(matching: .other).element.tap()
        tablesQuery.children(matching: .other).element.swipeUp()
        tablesQuery.children(matching: .other).element.swipeDown()
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.navigationBars["Contacts_App.CreateContactView"].buttons["Cancel"].tap()
        
        XCTAssertNotEqual(app.tables, nil)
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
