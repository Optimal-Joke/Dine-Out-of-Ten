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
    var id: UUID = UUID()
    
    @Published var name: String
    @Published var menuDescription: String = ""
    
    @Published var tags: OrderedSet<Tag> = OrderedSet<Tag>()
    @Published var orders: [Order] = [Order]()
    
    @Published var wouldOrderAgain: WouldOrderAgain = .notSpecified
    @Published var tips: String = ""
    
    init(name: String) {
        self.name = name
    }
    
    convenience init(name: String, description: String) {
        self.init(name: name)
        self.menuDescription = description
        self.tags = OrderedSet<Tag>()
        self.orders = [Order]()
        self.wouldOrderAgain = .notSpecified
        self.tips = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        menuDescription = try container.decode(String.self, forKey: .menuDescription)
        tags = try container.decode(OrderedSet<Tag>.self, forKey: .tags)
        orders = try container.decode([Order].self, forKey: .orders)
        wouldOrderAgain = try container.decode(WouldOrderAgain.self, forKey: .wouldOrderAgain)
        tips = try container.decode(String.self, forKey: .tips)
    }
    
    convenience init(tags: OrderedSet<Tag>) {
        self.init(name: "Placeholder", description: "")
        self.tags.append(contentsOf: tags)
    }
    
    enum WouldOrderAgain: String, Codable {
        case yes, no, notSpecified
    }
}

extension MenuItem: Equatable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name // TODO: Check that this does indeed verify uniqueness
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
