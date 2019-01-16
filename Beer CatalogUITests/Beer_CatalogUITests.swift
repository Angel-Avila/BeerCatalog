//
//  Beer_CatalogUITests.swift
//  Beer CatalogUITests
//
//  Created by Angel Avila on 1/14/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import XCTest

class Beer_CatalogUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()

    }

    func testDetailsExist() {
        
        let tableview = app.tables.matching(identifier: "tvAccessibilityIdentifier")
        let cell = tableview.cells.element(matching: .cell, identifier: "cell1")
        cell.tap()
        
        let sv = app.scrollViews.matching(identifier: "svIdentifier").element
       XCTAssertTrue(sv.exists)
        
        let details = sv.otherElements.matching(identifier: "beerDetailsView").element
        XCTAssertTrue(details.exists)
        
        let imageView = details.images.matching(identifier: "beerAccesibilityId").element
        XCTAssertTrue(imageView.exists)
    }
}


