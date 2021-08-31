//
//  DineOutofTenTests.swift
//  DineOutofTenTests
//
//  Created by Hunter Holland on 5/11/21.
//

import XCTest
@testable import Dine_Out_of_Ten
import SwiftUI
import MapKit


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

    func testAverageRating() throws {
        let testRest = Restaurant(name: "Test Rest")
        var ratings = [Int]()

        let n = 5
        for r in 1...n {
            ratings.append(r)
            let newOrder = MenuItem(name: "New")
            testRest.orderItem(newOrder, withRating: r, atPrice: 3.14, withNotes: "Test \(r)")
        }

        // Calculate average straight from raw Ratings
        let trueAvg = Rating(ratings.reduce(0.0) { $0 + Float($1) / Float(ratings.count) })

        // Calculate average using average rating property
        let avg = testRest.menuItems[0].averageRating

        XCTAssert(avg == trueAvg)
        }

    func testHighestRatedItem() {
        let testRest = Restaurant(name: "Test Rest")
        let lowRatingOrder = MenuItem(name: "Bad")
        let highRatingOrder = MenuItem(name: "Good")

        testRest.orderItem(lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
        testRest.orderItem(highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")

        XCTAssertNotNil(testRest.highestRatedItem!)
        XCTAssert(testRest.highestRatedItem! == highRatingOrder)
    }

    func testLowestRatedItem() {
        let testRest = Restaurant(name: "Test Rest")
        let lowRatingOrder = MenuItem(name: "Bad")
        let highRatingOrder = MenuItem(name: "Good")

        testRest.orderItem(lowRatingOrder, withRating: 2, atPrice: 3.14, withNotes: "This was terrible")
        testRest.orderItem(highRatingOrder, withRating: 9, atPrice: 3.14, withNotes: "This was really good")

        XCTAssertNotNil(testRest.lowestRatedItem!)
        XCTAssert(testRest.lowestRatedItem! == lowRatingOrder)
    }

    func testAddTagsToMenuItem() throws {
        let user = User.example
        let item = MenuItem.example
        let tag = Tag.example

        try! user.addTag(tag, to: item)

        XCTAssertTrue(item.tags.count == 2, "\(item.tags.count) != 2")
        XCTAssertTrue(user.menuItemTags.count == 2, "\(user.menuItemTags.count) != 2")
    }
    
    func testRestaurantInitialValues() throws {
        let restaurant = Restaurant()
        
        XCTAssertEqual(restaurant.name, "")
        XCTAssertTrue(restaurant.tags.isEmpty)
        XCTAssertTrue(restaurant.menuItems.isEmpty)
//        XCTAssertNil(restaurant.coordinate)
//        XCTAssertNil(restaurant.location2)
    }
    
    // MARK: Location2
    func testSetCoordinateDoesSetValue() throws {
        let placemark = Placemark()
        
        // set coordinate
        let coordinate = Coordinate(latitude: 40.92553, longitude: -73.96488)
        placemark.coordinate = coordinate
        
        // test coordinate set also sets location2
        XCTAssertNotNil(placemark.coordinate)
        XCTAssertNotNil(placemark.location)
        
        XCTAssertEqual(placemark.coordinate?.latitude, placemark.location?.coordinate.latitude)
        XCTAssertEqual(placemark.coordinate?.longitude, placemark.location?.coordinate.longitude)

    }
    
    func testResetCoordinateDoesResetValue() throws {
        let placemark = Placemark()
        
        // set coordinate
        let coordinate = Coordinate(latitude: 40.92553, longitude: -73.96488)
        placemark.coordinate = coordinate
        
        // reset coordinate
        placemark.coordinate = nil
        
        // test coordinate reset also resets location
        XCTAssertNil(placemark.coordinate)
        XCTAssertNil(placemark.location)
    }
    
//    func testGetPlacemarkFromLocation() throws {
//        let location = Location2(latitude: 40.92553, longitude: -73.96488)
//
//        let expectation = XCTestExpectation(description: "Placemark loaded")
//
//        location.getPlacemark { (placemark: CLPlacemark?) in
//            XCTAssertNotNil(placemark)
//
//            if let placemark = placemark {
//                let mkplacemark = MKPlacemark(placemark: placemark)
//                let mapItem = MKMapItem(placemark: mkplacemark)
//
//                XCTAssertTrue(mapItem.name!.contains("Diner"), "MapItem name: \(mapItem.name!)")
//                print("TESTTESTTEST", mapItem.name!)
//
//                expectation.fulfill()
//            }
//
//            XCTAssertEqual(placemark!.name!, "16 W Railroad Ave", "The address \(String(describing: placemark!.name)) does not match Address")
//        }
//
//        wait(for: [expectation], timeout: 1)
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
