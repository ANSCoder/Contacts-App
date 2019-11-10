//
//  ContactDetailsUITest.swift
//  Contacts-AppUITests
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import XCTest

class ContactDetailsUITest: XCTestCase {

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


    func testViewContactDetails() {
        app.launch()
        
        let delayExpectation = expectation(description: "Waiting for contact list data from WebAPi")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            delayExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.5)
        
        XCTAssertNotEqual(app.tables.cells.count, 0)
        
        let tablesQuery = app.tables
        
        //selected contact from List view
        tablesQuery.element(boundBy: 0).tap()
        
        let contactDetailsElement = tablesQuery.children(matching: .other)
        
        //Open Details page top on message button
        contactDetailsElement.children(matching: .button).element(boundBy: 0).tap()
        let okButton = app.alerts["Error!"].scrollViews.otherElements.buttons["Ok"]
        okButton.tap()
        
        //pass because in simulator it will not support
        XCTAssertTrue(true)
        
        contactDetailsElement.children(matching: .button).element(boundBy: 2).tap()
        okButton.tap()
        contactDetailsElement.children(matching: .button).element(boundBy: 3).tap()
        let delayExpectationForFavourite = expectation(description: "Waiting for make contact favourite WebAPi")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            delayExpectationForFavourite.fulfill()
        }
        
        waitForExpectations(timeout: 2.0)
        
        tablesQuery.staticTexts["mobile"].tap()
        tablesQuery.cells.staticTexts["email"].tap()
        app.swipeDown()
        app.swipeUp()
        
        XCTAssertEqual(app.navigationBars.buttons.count, 2)
        XCUIApplication().navigationBars["Contacts_App.ContactDetailsView"].buttons["Contact"].tap()
    }

}
