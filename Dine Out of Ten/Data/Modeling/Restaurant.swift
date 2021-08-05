//
//  Restaurant.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import OrderedCollections
import SwiftUI
import MapKit

final class Restaurant: ObservableObject, Identifiable, Taggable {    
    var id: UUID
    
    @Published var name: String
    @Published var tags = OrderedSet<Tag>()
    var menuItems = [MenuItem]()
    
    @Published var location: Location = Location()
    
    init() {
        self.id = UUID()
        self.name = ""
    }
        
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        tags = try container.decode(OrderedSet<Tag>.self, forKey: .tags)
        menuItems = try container.decode([MenuItem].self, forKey: .menuItems)
        location = try container.decode(Location.self, forKey: .location)
    }
    
    static var empty: Restaurant {
        Restaurant()
    }
}

extension Restaurant: Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name && lhs.location == rhs.location // TODO: verify that this does indeed check for uniqueness
    }
}

// MARK: - Location Information
private extension Restaurant {
    var city: String {
        self.location.placemark?.city ?? ""
    }
    
    var state: String {
        self.location.placemark?.state ?? ""
    }
    
    var country: String {
        self.location.placemark?.country ?? ""
    }
}

// MARK: - Display Information
extension Restaurant {
    var locationDescription: String {
        location.placemark != nil ? "\(city), \(state)" : ""
    }
    
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

extension Restaurant {
    
}


