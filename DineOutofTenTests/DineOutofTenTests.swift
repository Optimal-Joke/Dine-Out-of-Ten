//
//  DineOutofTenTests.swift
//  DineOutofTenTests
//
//  Created by Hunter Holland on 5/11/21.
//

import XCTest
@testable import Dine_Out_of_Ten


class DineOutofTenTests: XCTestCase {
    var sut: Dine_Out_of_TenApp!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = Dine_Out_of_TenApp()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testAddOrders() throws {
        let nInstances = 10
        let user = User(generateTestData: true, ordersPerItem: nInstances)
        
        for restaurant in user.restaurants {
            for item in restaurant.menuItems {
                XCTAssert(item.numOrders == nInstances)
            }
        }
        
    }
    
    func testAverageRating() throws {
        let testRest = Restaurant(name: "Test Rest")
        var ratings = [Int]()

        let n = 5
        for r in 1...n {
            ratings.append(r)
            let newOrder = MenuItem(name: "New", restaurant: testRest)
            testRest.addNewOrder(of: newOrder, withRating: r, atPrice: 3.14, withNotes: "Test \(r)")
        }
        
        // Calculate average straight from raw Ratings
        let trueAvg = Rating(ratings.reduce(0.0) { $0 + Float($1) / Float(ratings.count) })
        
        // Calculate average using average rating property
        let avg = testRest.menuItems[0].averageRating

        XCTAssert(avg == trueAvg)
        }
    
    func testHighestRatedItem() {
        let testRest = Restaurant(name: "Test Rest")
        let lowRatingOrder = MenuItem(name: "Bad", restaurant: testRest)
        let highRatingOrder = MenuItem(name: "Good", restaurant: testRest)
        
        testRest.addNewOrder(of: lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
        testRest.addNewOrder(of: highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")
        
        XCTAssert(testRest.highestRatedItem == highRatingOrder)
    }
    
    func testLowestRatedItem() {
        let testRest = Restaurant(name: "Test Rest")
        let lowRatingOrder = MenuItem(name: "Bad", restaurant: testRest)
        let highRatingOrder = MenuItem(name: "Good", restaurant: testRest)
        
        testRest.addNewOrder(of: lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
        testRest.addNewOrder(of: highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")
        
        XCTAssert(testRest.lowestRatedItem == lowRatingOrder)
    }
    
    func testAddTagsToMenuItem() throws {
        let user = User()
        let restaurant = Restaurant(name: "Test Rest", city: "Treasure Island", state: "FL")
        let item = MenuItem(name: "Test Item", description: "This is a test description", restaurant: restaurant)
        
        user.addTag(label: "🐟 Seafood", colors: [.orange], to: item)
        user.addTag(label: "Entree", colors: [.yellow], to: item)
        user.addTag(label: "Favorite", colors: [.blue], to: item)
        user.addTag(label: "England", colors: [.red], to: item)
        user.addTag(label: "Fried", colors: [.pink], to: item)
        
        XCTAssert(item.tags.count == 5)
        XCTAssert(user.menuItemTags.count == 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
