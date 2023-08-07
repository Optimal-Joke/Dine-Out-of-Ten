//
//  TestData.swift
//  TestData
//
//  Created by Hunter Holland on 7/21/21.
//

import SwiftUI
import MapKit

// MARK: User
extension User {
    fileprivate func addTag(label: String, colors: [Color], to item: Taggable) {
        let newTag = Tag(label: label, colors: colors)
        try! self.addTag(newTag, to: item)
    }
    
    internal func generateTestData(ordersPerItem: Int) {
        // MARK: Test Data
        let testRestaurant = Restaurant(name: "Tenafly Diner")
        let testPlacemark = Placemark(latitude: 40.92553, longitude: 73.96485)
        let testRestaurantTag = Tag(label: "Test Restaurant Tag", colors: [.red])
        let testMenuItemTag1 = Tag(label: "Test 1", colors: [.blue])
        let testMenuItemTag2 = Tag(label: "Test 2", colors: [.teal])
                
        let testMenuItem = MenuItem(name: "Fish and Chips", description: "Cod with a side of french fries")
        
        // MARK: Assembling Data
        testRestaurant.placemark = testPlacemark
        try! self.addTag(testRestaurantTag, to: testRestaurant)
        self.restaurants.append(testRestaurant)
        
        try! self.addTag(testMenuItemTag1, to: testMenuItem)
        try! self.addTag(testMenuItemTag2, to: testMenuItem)
        
        testRestaurant.orderItem(testMenuItem, withRating: 10, atPrice: 14.99, withNotes: "This was amazing")
        
        // Order ordersPerItem more times
        for i in 2...ordersPerItem {
            testRestaurant.orderItem(testMenuItem, withRating: i, atPrice: Double.random(in: 10.99...17.99), withNotes: "Test Note \(i) for \(testMenuItem.name)")
        }
    }
}


extension User {
    static var example: User {
        User(testOrdersPerItem: 10)
    }
}

// MARK: Restaurant
extension Restaurant {
    static var example: Restaurant {
        User.example.restaurants[0]
    }
}

// MARK: Placemark
extension Placemark {
    static var example: Placemark {
        Restaurant.example.placemark
    }
}

// MARK: MenuItem
extension MenuItem {
    static var example: MenuItem {
        Restaurant.example.menuItems[0]
    }
}

// MARK: Coordinate
extension Coordinate {
    static var example: Coordinate {
        Restaurant.example.placemark.coordinate!
    }
}
