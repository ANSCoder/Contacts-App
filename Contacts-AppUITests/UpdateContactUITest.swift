//
//  UpdateContactUITest.swift
//  Contacts-AppUITests
//
//  Created by Anand Nimje on 11/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import XCTest

class UpdateContactUITest: XCTestCase {
    
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
    
    func testUpdateContactDetails() {
        app.launch()
        
        let delayExpectation = expectation(description: "Waiting for contact list data from WebAPi")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            delayExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.5)
        
        XCTAssertNotEqual(app.tables.cells.count, 0)
        
        let tablesQuery = app.tables
        
        tablesQuery.element(boundBy: 0).tap()
       
        app.navigationBars["Contacts_App.ContactDetailsView"].buttons["Edit"].tap()
        
        app.swipeDown()
        
        //Swipe down page
        XCTAssertTrue(true)
        
        app.swipeUp()
        
        XCTAssertNotEqual(app.tables.cells.count, 4)
        XCTAssertEqual(app.tables.cells.count, 2)
        XCTAssertTrue(true)
    
        let contactsAppContactdetailsviewNavigationBar = app.navigationBars["Contacts_App.ContactDetailsView"]
        contactsAppContactdetailsviewNavigationBar.buttons["Edit"].tap()
        app.navigationBars["Contacts_App.EditContactView"].buttons["Cancel"].tap()
        contactsAppContactdetailsviewNavigationBar.buttons["Contact"].tap()
        
    }
    
}
