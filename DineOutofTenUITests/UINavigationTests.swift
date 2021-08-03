//
//  UINavigationTests.swift
//  DineOutofTenUITests
//
//  Created by Hunter Holland on 7/5/21.
//

import XCTest


class UINavigationTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
//    func testNavigateToEachRestaurant() throws {
//        
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Tenafly Diner, Tenafly, 6.2/10"]/*[[".cells[\"Tenafly Diner, Tenafly, 6.2\/10\"].buttons[\"Tenafly Diner, Tenafly, 6.2\/10\"]",".buttons[\"Tenafly Diner, Tenafly, 6.2\/10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.navigationBars["Tenafly Diner"].buttons["My Restaurants"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["The Floridian, Treasure Island, 6.3/10"]/*[[".cells[\"The Floridian, Treasure Island, 6.3\/10\"].buttons[\"The Floridian, Treasure Island, 6.3\/10\"]",".buttons[\"The Floridian, Treasure Island, 6.3\/10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.navigationBars["The Floridian"].buttons["My Restaurants"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Johns of Bleeker Street, New York, 6.3/10"]/*[[".cells[\"Johns of Bleeker Street, New York, 6.3\/10\"].buttons[\"Johns of Bleeker Street, New York, 6.3\/10\"]",".buttons[\"Johns of Bleeker Street, New York, 6.3\/10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.navigationBars["Johns of Bleeker Street"].buttons["My Restaurants"].tap()
//                
//    }
}
