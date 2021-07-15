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
    
    init(generateTestData: Bool = false, ordersPerItem: Int = 10) {
        if generateTestData { self.generateTestData(ordersPerItem: ordersPerItem) }
    }
    
    var menuItems: [MenuItem] {
        restaurants.flatMap { $0.menuItems }
    }
}

// MARK: Testing
extension User {
    private func generateTestData(ordersPerItem: Int) {
        // Define test restaurants
        let tenaflyDiner = Restaurant(name: "Tenafly Diner", city: "Tenafly", state: "NJ")
        let theFloridian = Restaurant(name: "The Floridian", city: "Treasure Island", state: "FL")
        let johns        = Restaurant(name: "Johns of Bleeker Street", city: "New York", state: "NY")
        
        // Add test restaurants to user
        self.restaurants.append(tenaflyDiner)
        self.restaurants.append(theFloridian)
        self.restaurants.append(johns)
        
        // Define test menu items
        let fishNchips     = MenuItem(name: "Fish and Chips", description: "Cod with a side of french fries", restaurant: tenaflyDiner)
        let cuban          = MenuItem(name: "Cuban Sandwich", description: "Panini with ham, cheese, roast beef, and mustard", restaurant: theFloridian)
        let cheesePizza    = MenuItem(name: "Cheese Pizza", description: "The best cheese pizza around.", restaurant: johns)
        let potatoSkins    = MenuItem(name: "Potato Skins", description: "Potehto boats", restaurant: tenaflyDiner)
        let bread          = MenuItem(name: "Cuban Bread", description: "Just the bread", restaurant: theFloridian)
        let pepperoniPizza = MenuItem(name: "Pepperoni Pizza", description: "The best pepperoni pizza around.", restaurant: johns)
        
        // Add tags
        self.addTag(label: "🐟 Seafood", colors: [.orange], to: fishNchips)
        self.addTag(label: "Entree", colors: [.yellow], to: fishNchips)
        self.addTag(label: "Favorite", colors: [.blue], to: fishNchips)
        self.addTag(label: "England", colors: [.red], to: fishNchips)
        self.addTag(label: "Comes With Side", colors: [.green], to: fishNchips)
        self.addTag(label: "Fried", colors: [.pink], to: fishNchips)
        
        
        // Order once/add items to restaurants
        tenaflyDiner.addNewOrder(of: fishNchips, withRating: 10, atPrice: 14.99, withNotes: "This was amazing")
        theFloridian.addNewOrder(of: cuban, withRating: 7, atPrice: 9.99, withNotes: "This was a pretty good cuban")
        johns.addNewOrder(of: cheesePizza, withRating: 10, atPrice: 12.99, withNotes: "BEST PIZZA EVER")
        tenaflyDiner.addNewOrder(of: potatoSkins, withRating: 5, atPrice: 5.99, withNotes: "Cammy likes this")
        theFloridian.addNewOrder(of: bread, withRating: 10, atPrice: 2.99, withNotes: "best bread ever")
        johns.addNewOrder(of: pepperoniPizza, withRating: 8, atPrice: 14.99, withNotes: "Not as good as the cheese pizza")
        
        // Order ordersPerItem more times
        for i in 2...ordersPerItem {
            tenaflyDiner.addNewOrder(of: fishNchips, withRating: i, atPrice: Double.random(in: 10.99...17.99), withNotes: "Test Note \(i) for \(fishNchips.name)")
            theFloridian.addNewOrder(of: cuban, withRating: i, atPrice: Double.random(in: 7.99...11.99), withNotes: "Test Note \(i) for \(cuban.name)")
            johns.addNewOrder(of: cheesePizza, withRating: i, atPrice: Double.random(in: 10.99...13.99), withNotes: "Test Note \(i) for \(cheesePizza.name)")
            tenaflyDiner.addNewOrder(of: potatoSkins, withRating: i, atPrice: Double.random(in: 3.99...6.99), withNotes: "Test Note \(i) for \(potatoSkins.name)")
            theFloridian.addNewOrder(of: bread, withRating: i, atPrice: Double.random(in: 1.99...3.99), withNotes: "Test Note \(i) for \(bread.name)")
            johns.addNewOrder(of: pepperoniPizza, withRating: i, atPrice: Double.random(in: 12.99...15.99), withNotes: "Test Note \(i) for \(pepperoniPizza.name)")
        }
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
