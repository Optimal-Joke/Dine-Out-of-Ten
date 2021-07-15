//
//  Restaurant.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import Foundation
import OrderedCollections
import SwiftUI
import MapKit

//struct FinalRestaurant {
//    let id = UUID()
//    let name: String
//    let city: String
//    let state: String
//    var coordinates: CLLocationCoordinate2D
//    var description: String
//    var menuItems: [MenuItem]
//
//    var formattedLocation: String {
//        "\(city), \(state)"
//    }
//}
//


class Restaurant: ObservableObject, Identifiable, Taggable {    
    let id = UUID()
    
    var name: String
    var city: String = "City"
    var state: String = "State"
    var stateShort: String = "ST"
    
    @Published var tags = OrderedSet<Tag>()
    var menuItems = [MenuItem]()
    
    static var example: Restaurant {
        let ex = Restaurant(name: "Tenafly Diner", city: "Tenafly", state: "NJ")
        let fishNchips = MenuItem(name: "Fish and Chips", description: "Cod with a side of french fries", restaurant: ex)
        let potatoSkins = MenuItem(name: "Potato Skins", description: "Potehto boats", restaurant: ex)
        ex.addNewOrder(of: fishNchips, withRating: 10, atPrice: 14.99, withNotes: "This was amazing")
        ex.addNewOrder(of: potatoSkins, withRating: 5, atPrice: 5.99, withNotes: "Cammy likes this")
        for i in 2...10 {
            ex.addNewOrder(of: fishNchips, withRating: Int.random(in: 1...10), atPrice: Double.random(in: 10.99...17.99), withNotes: "Test Note \(i) for \(fishNchips.name)")
            ex.addNewOrder(of: potatoSkins, withRating: Int.random(in: 1...10), atPrice: Double.random(in: 3.99...6.99), withNotes: "Test Note \(i) for \(potatoSkins.name)")
        }
        return ex
    }
        
    init(name: String) {
        self.name = name
    }
    
    convenience init(name: String, city: String, state: String) {
        self.init(name: name)
        self.city = city
        self.state = state
    }
}

extension Restaurant: CustomStringConvertible, Equatable {
    var description: String {
        "\(name)"
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id // TODO: verify that this does indeed check for uniqueness
    }
}

extension Restaurant {
    var averageRating: Rating {
        menuItems.map { $0.averageRating }.average
    }
    
    var highestRatedItem: MenuItem? {
        menuItems.max { $0.averageRating < $1.averageRating }
    }

    var lowestRatedItem: MenuItem? {
        menuItems.min { $0.averageRating < $1.averageRating }
    }

    var totalOrders: Int {
        menuItems.flatMap { $0.orders }.count
    }

    var uniqueOrders: Int {
        menuItems.count
    }
    
    func distance(to: Restaurant) {
        
    }
}


