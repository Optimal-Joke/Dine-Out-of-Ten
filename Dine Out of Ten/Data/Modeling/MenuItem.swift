//
//  MenuItem.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import Foundation
import OrderedCollections
import SwiftUI

// MARK: Declaration
class MenuItem: ObservableObject, Identifiable, Taggable {    
    let id = UUID()
    
    @Published var name: String
    @Published var menuDescription: String
    @Published var restaurant: Restaurant
    
    @Published var wouldOrderAgain: FutureOrderPotential = .notSpecified
    @Published var tips: String = ""
    
    @Published var tags = OrderedSet<Tag>()
    @Published var orders = [Order]()
    
    init(name: String, description: String, restaurant: Restaurant) {
        self.name = name
        self.restaurant = restaurant
        self.menuDescription = description
    }
    
    convenience init(name: String, restaurant: Restaurant) {
        self.init(name: name, description: "", restaurant: restaurant)
    }
    
    convenience init(tags: OrderedSet<Tag>) {
        self.init(name: "Placeholder", description: "", restaurant: Restaurant.example)
        self.tags.append(contentsOf: tags)
    }
    
    enum FutureOrderPotential {
        case wouldOrderAgain, wouldNotOrderAgain, notSpecified
    }
}

// MARK: Testing
extension MenuItem {
    internal static var example: MenuItem {
        let testUser = User()
        
        let testRest = Restaurant(name: "Test Rest", city: "Treasure Island", state: "FL")
        let ex = MenuItem(name: "Test Item", description: "This is a test description", restaurant: testRest)
        
        testRest.addNewOrder(of: ex, withRating: 10, atPrice: 14.99, withNotes: "This was amazing")
        testUser.addTag(label: "🐟 Seafood", colors: [.orange], to: ex)
        testUser.addTag(label: "Entree", colors: [.yellow], to: ex)
        testUser.addTag(label: "Favorite", colors: [.blue], to: ex)
        testUser.addTag(label: "England", colors: [.red], to: ex)
        testUser.addTag(label: "Comes With Side", colors: [.green], to: ex)
        testUser.addTag(label: "Fried", colors: [.pink], to: ex)
        
        for i in 2...10 {
            testRest.addNewOrder(of: ex, withRating: Int.random(in: 1...10), atPrice: Double.random(in: 10.99...17.99), withNotes: "Test Note \(i) for \(ex.name)")
        }
        
        return ex
    }
}

extension MenuItem: CustomStringConvertible, Equatable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(ObjectIdentifier(self).hashValue)
//    }
    
    @objc var description: String {
        "\(name), \(averageRating)"
//        "\(name)"
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.restaurant == rhs.restaurant
    }
}

extension MenuItem {
    var numOrders: Int {
        orders.count
    }
    
    var priceNow: Double {
        get {
            // TODO: compute this from list of MenuItemOrders
            return 0.00
        }
    }
    
    var lastConsumed: Date {
        get {
            // TODO: compute this from list of MenuItemOrders
            return Date()
        }
    }

    var averageRating: Rating {
        orders.map { $0.rating }.average
    }
    
    var rank: Int {
        let itemsHigher = self.restaurant.menuItems.filter {
            $0.averageRating > self.averageRating
        }

        return itemsHigher.count + 1
        
    }
}

enum MenuItemType: String, CaseIterable {
    case appetizer
    case entree
    case salad
    case soup
    case drink
    case side
    case dessert
    case other
}
