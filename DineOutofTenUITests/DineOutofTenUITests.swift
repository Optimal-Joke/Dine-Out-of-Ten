//
//  DineOutofTenUITests.swift
//  DineOutofTenUITests
//
//  Created by Hunter Holland on 5/11/21.
//

import XCTest

class DineOutofTenUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCUIApplication().launch()
        
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
    
//    func testAddRestaurantBySearch() throws {
//
//        let app = XCUIApplication()
//        app.navigationBars["My Restaurants"].children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).element.tap()
//        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Add Restaurant"]/*[[".cells.buttons[\"Add Restaurant\"]",".buttons[\"Add Restaurant\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.searchFields["Restaurants, cafés, and more..."].tap()
//        app.searchFields["Restaurants, cafés, and more..."].typeText("Tenafly Diner")
//
//        let tablesQuery = app.tables
//        let label = tablesQuery.staticTexts["Tenafly Classic Diner, 16 W Railroad Ave, Tenafly, NJ  07670, United States"]
//        let exists = NSPredicate(format: "exists == 1")
//        expectation(for: exists, evaluatedWith: label, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//
//        tablesQuery.cells["Tenafly Classic Diner, 16 W Railroad Ave, Tenafly, NJ  07670, United States"].children(matching: .other).element(boundBy: 3).children(matching: .other).element.tap()
//        app.navigationBars["New Restaurant"].buttons["Add"].tap()
//        app.navigationBars["Restaurant Search"].children(matching: .other).element.children(matching: .other).element.tap()
//        tablesQuery.cells["Tenafly Classic Diner, Tenafly, NJ, 0.0/10"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
//
//    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
