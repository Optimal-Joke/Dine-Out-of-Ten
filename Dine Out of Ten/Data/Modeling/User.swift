//
//  User.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation
import Collections

// MARK: Declaration
class User: ObservableObject, Identifiable  {
    let id = UUID()
    
    @Published var restaurants = [Restaurant]()
    @Published var menuItemTags = OrderedSet<Tag>()
    @Published var restaurantTags = OrderedSet<Tag>()
    
    init() {

    }
    
    init(testOrdersPerItem: Int = 10) {
        self.generateTestData(ordersPerItem: testOrdersPerItem)
    }
    
    var menuItems: [MenuItem] {
        restaurants.flatMap { $0.menuItems }
    }
}

extension User {
    func getRestaurant(withID id : UUID) -> Restaurant {
        restaurants.first { $0.id == id }!
    }
}

//class User: ObservableObject, Codable {
//    @Published var name = "Paul Hudson"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//
//    enum CodingKeys: CodingKey {
//        case name
//    }
//}
