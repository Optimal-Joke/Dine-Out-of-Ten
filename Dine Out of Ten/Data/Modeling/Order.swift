//
//  Order.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation
import SwiftUI

class Order: Identifiable {    
    let id = UUID()
    let dateConsumed = Date()
    
    let item: MenuItem
    var rating: Rating
    var price: Double?
    var userNotes: String
    
    init(of item: MenuItem, withRating rating: Int, atPrice price: Double? = nil, withNotes notes: String?) {
        self.item = item
        self.rating = Rating(rating)
        self.price = price
        self.userNotes = notes ?? ""
    }
    
    convenience init(of item: MenuItem, withRating rating: Int) {
        self.init(of: item, withRating: rating, atPrice: nil, withNotes: nil)
    }
}

extension Order: CustomStringConvertible, Equatable, Hashable {
    var description: String {
        "\(item.name), \(dateConsumed.format(dateStyle: .medium)), \(rating)"
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.dateConsumed == rhs.dateConsumed
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}
