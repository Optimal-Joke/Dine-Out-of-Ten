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
    
//    func load() {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let data = try? Data(contentsOf: Self.fileURL) else {
//                #if DEBUG
//                DispatchQueue.main.async {
////                    self?.scrums = DailyScrum.data
//                }
//                #endif
//                return
//            }
//            guard let restaurants = try? JSONDecoder().decode([Restaurant].self, from: data) else {
//                fatalError("Can't decode saved scrum data.")
//            }
//            DispatchQueue.main.async {
//                self?.scrums = dailyScrums
//            }
//        }
//    }
}

extension User {
    var menuItems: [MenuItem] {
        restaurants.flatMap { $0.menuItems }
    }
    
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
