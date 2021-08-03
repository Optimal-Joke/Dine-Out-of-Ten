//
//  TestData.swift
//  TestData
//
//  Created by Hunter Holland on 7/21/21.
//

import SwiftUI

// MARK: User
extension User {
    fileprivate func addTag(label: String, colors: [Color], to item: Taggable) {
        let newTag = Tag(label: label, colors: colors)
        try! self.addTag(newTag, to: item)
    }
    
    internal func generateTestData(ordersPerItem: Int) {
        // Define test restaurants
        let tenaflyDiner = Restaurant(name: "Tenafly Diner")
        tenaflyDiner.address = "16 W Railroad Ave, Tenafly, NJ 07670"
        tenaflyDiner.placemark = Placemark(latitude: 40.92553, longitude: 73.96485)
        
        // Add test restaurants to user
        self.restaurants.append(tenaflyDiner)
        
        // Define test menu items
        let fishNchips     = MenuItem(name: "Fish and Chips", description: "Cod with a side of french fries", restaurant: tenaflyDiner)
        let potatoSkins    = MenuItem(name: "Potato Skins", description: "Potehto boats", restaurant: tenaflyDiner)
        
        // Add tags to items
        self.addTag(label: "🐟 Seafood", colors: [.orange], to: fishNchips)
        self.addTag(label: "Entree", colors: [.yellow], to: fishNchips)
        self.addTag(label: "Favorite", colors: [.blue], to: fishNchips)
        self.addTag(label: "England", colors: [.red], to: fishNchips)
        self.addTag(label: "Comes With Side", colors: [.green], to: fishNchips)
        self.addTag(label: "Fried", colors: [.pink], to: fishNchips)
        
        // Add tags to restaurants
        for i in 1...5 {
            self.addTag(label: "Tag \(i)", colors: [.random(), .random()], to: tenaflyDiner)
        }
        
        // Order once + add items to restaurants
        tenaflyDiner.orderItem(fishNchips, withRating: 10, atPrice: 14.99, withNotes: "This was amazing")
        tenaflyDiner.orderItem(potatoSkins, withRating: 5, atPrice: 5.99, withNotes: "Cammy likes this")
        
        // Order ordersPerItem more times
        for i in 2...ordersPerItem {
            tenaflyDiner.orderItem(fishNchips, withRating: i, atPrice: Double.random(in: 10.99...17.99), withNotes: "Test Note \(i) for \(fishNchips.name)")
            tenaflyDiner.orderItem(potatoSkins, withRating: i, atPrice: Double.random(in: 3.99...6.99), withNotes: "Test Note \(i) for \(potatoSkins.name)")
        }
        
        for i in 1...10 {
            tenaflyDiner.orderItem(MenuItem(name: "Test Order \(i)", restaurant: tenaflyDiner), withRating: 8)
        }
    }
}

// MARK: Restaurant
extension Restaurant {
    internal static var example: Restaurant {
        User(testOrdersPerItem: 10).restaurants[0]
    }
}

// MARK: MenuItem
extension MenuItem {
    internal static var example: MenuItem {
        User(testOrdersPerItem: 10).restaurants[0].menuItems[0]
    }
}
