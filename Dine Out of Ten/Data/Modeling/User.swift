//
//  User.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation
import Collections

// MARK: Declaration
final class User: ObservableObject, Identifiable  {
    var id = UUID()
    
    @Published var restaurants = [Restaurant]()
    @Published var menuItemTags = OrderedSet<Tag>()
    @Published var restaurantTags = OrderedSet<Tag>()
    
    init() {

    }
    
    init(testOrdersPerItem: Int = 10) {
        self.generateTestData(ordersPerItem: testOrdersPerItem)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        restaurants = try container.decode([Restaurant].self, forKey: .restaurants)
        menuItemTags = try container.decode(OrderedSet<Tag>.self, forKey: .menuItemTags)
        restaurantTags = try container.decode(OrderedSet<Tag>.self, forKey: .restaurantTags)
    }
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("user.data")
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
//                    self?.scrums = DailyScrum.data
                }
                #endif
                return
            }
            guard let restaurants = try? JSONDecoder().decode([Restaurant].self, from: data) else {
                fatalError("Can't decode saved restaurant data.")
            }
            
            DispatchQueue.main.async {
                self?.restaurants = restaurants
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let jsonData = try encoder.encode(self?.restaurants)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension User {
    var menuItems: [MenuItem] {
        restaurants.flatMap { $0.menuItems }
    }
    
    func getRestaurant(withID id : UUID) -> Restaurant {
        restaurants.first { $0.id == id }!
    }
    
    func addRestaurant(_ restaurant: Restaurant) {
        self.restaurants.append(restaurant)
    }
}

extension User: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(restaurants, forKey: .restaurants)
        try container.encode(menuItemTags, forKey: .menuItemTags)
        try container.encode(restaurantTags, forKey: .restaurantTags)
    }

    enum CodingKeys: CodingKey {
        case id, restaurants, menuItemTags, restaurantTags
    }
}
