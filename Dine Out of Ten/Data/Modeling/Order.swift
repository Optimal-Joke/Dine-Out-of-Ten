//
//  Order.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct Order: Identifiable {
    var id: UUID
    var dateConsumed: Date
    var itemName: String
    
    var rating: Rating
    var price: Double
    var notes: String
    
    init(of item: MenuItem, withRating rating: Int, atPrice price: Double? = nil, withNotes notes: String?) {
        self.id = UUID()
        self.dateConsumed = Date()
        
        self.itemName = item.name
        self.rating = Rating(rating)
        self.price = price ?? item.priceNow
        self.notes = notes ?? ""
    }
    
    init(of item: MenuItem, withRating rating: Int) {
        self.init(of: item, withRating: rating, atPrice: nil, withNotes: nil)
    }
    
    static var example: Order {
        Order(of: MenuItem.example, withRating: 9, atPrice: 9.99, withNotes: "Test note.")
    }
}

extension Order: Equatable, Hashable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.dateConsumed == rhs.dateConsumed
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Order: Codable { }
