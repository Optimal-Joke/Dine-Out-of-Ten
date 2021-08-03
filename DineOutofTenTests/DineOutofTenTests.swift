//
//  DineOutofTenTests.swift
//  DineOutofTenTests
//
//  Created by Hunter Holland on 5/11/21.
//

import XCTest
//@testable import Dine_Out_of_Ten
//
//
//class DineOutofTenTests: XCTestCase {
//    var sut: Dine_Out_of_TenApp!
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        try super.setUpWithError()
//        sut = Dine_Out_of_TenApp()
//
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        sut = nil
//        try super.tearDownWithError()
//    }
//
//    func testAverageRating() throws {
//        let testRest = Restaurant(name: "Test Rest")
//        var ratings = [Int]()
//
//        let n = 5
//        for r in 1...n {
//            ratings.append(r)
//            let newOrder = MenuItem(name: "New", restaurant: testRest)
//            testRest.orderItem(newOrder, withRating: r, atPrice: 3.14, withNotes: "Test \(r)")
//        }
//
//        // Calculate average straight from raw Ratings
//        let trueAvg = Rating(ratings.reduce(0.0) { $0 + Float($1) / Float(ratings.count) })
//
//        // Calculate average using average rating property
//        let avg = testRest.menuItems[0].averageRating
//
//        XCTAssert(avg == trueAvg)
//        }
//
//    func testHighestRatedItem() {
//        let testRest = Restaurant(name: "Test Rest")
//        let lowRatingOrder = MenuItem(name: "Bad", restaurant: testRest)
//        let highRatingOrder = MenuItem(name: "Good", restaurant: testRest)
//
//        testRest.orderItem(lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
//        testRest.orderItem(highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")
//
//        XCTAssertNotNil(testRest.highestRatedItem!)
//        XCTAssert(testRest.highestRatedItem! == highRatingOrder)
//    }
//
//    func testLowestRatedItem() {
//        let testRest = Restaurant(name: "Test Rest")
//        let lowRatingOrder = MenuItem(name: "Bad", restaurant: testRest)
//        let highRatingOrder = MenuItem(name: "Good", restaurant: testRest)
//
//        testRest.orderItem(lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
//        testRest.orderItem(highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")
//
//        XCTAssertNotNil(testRest.lowestRatedItem!)
//        XCTAssert(testRest.lowestRatedItem! == lowRatingOrder)
//    }
//
//    func testAddTagsToMenuItem() throws {
//        let user = User()
//        let restaurant = Restaurant(name: "Test Rest")
//        let item = MenuItem(name: "Test Item", description: "This is a test description", restaurant: restaurant)
//        let tag1 = Tag(label: "🐟 Seafood", colors: [.orange])
//        let tag2 = Tag(label: "Entree", colors: [.yellow])
//        let tag3 = Tag(label: "Favorite", colors: [.blue])
//        let tag4 = Tag(label: "England", colors: [.red])
//        let tag5 = Tag(label: "Fried", colors: [.pink])
//
//        try! user.addTag(tag1, to: item)
//        try! user.addTag(tag2, to: item)
//        try! user.addTag(tag3, to: item)
//        try! user.addTag(tag4, to: item)
//        try! user.addTag(tag5, to: item)
//
//        XCTAssert(item.tags.count == 5)
//        XCTAssert(user.menuItemTags.count == 5)
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
