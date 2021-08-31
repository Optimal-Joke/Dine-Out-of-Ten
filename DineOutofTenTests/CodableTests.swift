//
//  CodableTests.swift
//  CodableTests
//
//  Created by Hunter Holland on 8/5/21.
//

import XCTest
@testable import Dine_Out_of_Ten


class CodableTests: XCTestCase {
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
    
//    func testUserCodable() throws {
//        typealias DataType = User
//
//        let item = DataType.example
//
//        let encoder = JSONEncoder()
//        let data = try encoder.encode(item)
//
//        let decoder = JSONDecoder()
//        let decodedItem = try decoder.decode(DataType.self, from: data)
//
//        XCTAssertEqual(item, decodedItem)
//    }
    
    func testRestaurantCodable() throws {
        typealias DataType = Restaurant
        
        let item = DataType.example
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(DataType.self, from: data)
        
        XCTAssertEqual(item, decodedItem)
    }
    
    func testPlacemarkCodable() throws {
        typealias DataType = Placemark
        
        let item = DataType.example
        
        // encode item
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        // decode item
        let decoder = JSONDecoder()
        let decodedItem = try! decoder.decode(DataType.self, from: data)
        
        // check for equivalence
        XCTAssertEqual(item, decodedItem)
    }
    
    func testMenuItemCodable() throws {
        typealias DataType = MenuItem
        
        let item = DataType.example
        
        // encode item
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        // decode item
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(DataType.self, from: data)
        
        // check for equivalence
        XCTAssertEqual(item, decodedItem)
    }
    
    func testOrderCodable() throws {
        typealias DataType = Order
        
        let item = DataType.example
        
        // encode item
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        // decode item
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(DataType.self, from: data)
        
        // check for equivalence
        XCTAssertEqual(item, decodedItem)
    }

    func testRatingCodable() throws {
        typealias DataType = Rating
        
        let item = DataType.example
        
        // encode item
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        // decode item
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(DataType.self, from: data)
        
        // check for equivalence
        XCTAssertEqual(item, decodedItem)
    }
    
    func testTagCodable() throws {
        typealias DataType = Tag
        
        let item = DataType.example
        
        // encode item
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        // decode item
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(DataType.self, from: data)
        
        // check for equivalence
        XCTAssertEqual(item, decodedItem)
    }
}
