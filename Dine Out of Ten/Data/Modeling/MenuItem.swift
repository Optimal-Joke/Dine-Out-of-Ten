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
final class MenuItem: ObservableObject, Identifiable, Taggable {    
    var id: UUID
    var restaurantID: UUID
    
    @Published var name: String
    @Published var menuDescription: String
    
    @Published var wouldOrderAgain: WouldOrderAgain
    @Published var tips: String
    
    @Published var tags: OrderedSet<Tag>
    @Published var orders: [Order]
    
    init(name: String, description: String, restaurant: Restaurant) {
        self.id = UUID()
        self.restaurantID = restaurant.id
        self.name = name
        self.menuDescription = description
        self.wouldOrderAgain = .notSpecified
        self.tips = ""
        self.tags = OrderedSet<Tag>()
        self.orders = [Order]()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        restaurantID = try container.decode(UUID.self, forKey: .restaurantID)
        name = try container.decode(String.self, forKey: .name)
        menuDescription = try container.decode(String.self, forKey: .menuDescription)
        wouldOrderAgain = try container.decode(WouldOrderAgain.self, forKey: .wouldOrderAgain)
        tips = try container.decode(String.self, forKey: .tips)
        tags = try container.decode(OrderedSet<Tag>.self, forKey: .tags)
        orders = try container.decode([Order].self, forKey: .orders)
    }
    
    convenience init(name: String, restaurant: Restaurant) {
        self.init(name: name, description: "", restaurant: restaurant)
    }
    
    convenience init(tags: OrderedSet<Tag>) {
        self.init(name: "Placeholder", description: "", restaurant: Restaurant.example)
        self.tags.append(contentsOf: tags)
    }
    
    enum WouldOrderAgain: String, Codable {
        case yes, no, notSpecified
    }
}

extension MenuItem: Equatable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(ObjectIdentifier(self).hashValue)
//    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.restaurantID == rhs.restaurantID
    }
}

extension MenuItem {
    var numOrders: Int {
        orders.count
    }
    
    var priceNow: Double {
        orders.count != 0 ? orders.compactMap { $0.price }.last! : 0.00
    }
    
    var lastConsumed: Date {
        orders.map { $0.dateConsumed }.last! // NOTE: SHOULD NEVER BE NIL
    }

    var averageRating: Rating {
        orders.map { $0.rating }.average
    }
}
