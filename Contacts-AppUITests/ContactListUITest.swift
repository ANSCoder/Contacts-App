//
//  ContactListUITest.swift
//  Contacts-AppUITests
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import XCTest

class ContactListUITest: XCTestCase {

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

    func testViewContactList() {
        app.launch()
        
        let delayExpectation = expectation(description: "Waiting for contact list data from WebAPi")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            delayExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.5)
        
        XCTAssertNotEqual(app.tables.cells.count, 0)
        
        app.swipeDown()
        app.swipeUp()
        
        //Fetch all contact list
        XCTAssertTrue(true)
    }

    func testOpenDetailPage() {
        app.launch()
        
        let delayExpectation = expectation(description: "Waiting for contact list data from WebAPi")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            delayExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.5)
        
        XCTAssertNotEqual(app.tables.cells.count, 0)
        
        app.tables.element(boundBy: 0).tap()
               app.navigationBars["Contacts_App.ContactDetailsView"].buttons["Contact"].tap()
    }
    
}
