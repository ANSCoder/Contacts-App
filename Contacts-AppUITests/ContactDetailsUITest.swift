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


    

}
