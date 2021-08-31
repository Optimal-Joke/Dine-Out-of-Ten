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
    var id = UUID()
    
    @Published var name: String
    @Published var tags = OrderedSet<Tag>()
    var menuItems = [MenuItem]()
    
//    @Published var location: Location = Location()
    
    @Published var placemark: Placemark = Placemark()
    
    init() {
        self.name = ""
    }
        
    init(name: String) {
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        tags = try container.decode(OrderedSet<Tag>.self, forKey: .tags)
        menuItems = try container.decode([MenuItem].self, forKey: .menuItems)
        placemark = try container.decode(Placemark.self, forKey: .placemark)
    }
    
    static var empty: Restaurant {
        Restaurant()
    }
}

extension Restaurant: Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name && lhs.placemark == rhs.placemark // TODO: verify that this does indeed check for uniqueness
    }
}

// MARK: - Location Information
private extension Restaurant {
    var city: String {
        self.placemark.locality ?? ""
    }
    
    var state: String {
        self.placemark.administrativeArea ?? ""
    }
    
    var country: String {
        self.placemark.country ?? ""
    }
    
    func replacePlacemark(with newPlacemark: Placemark) {
        self.placemark = newPlacemark
    }
        
//    private func assignPlacemark(from location: CLLocation?) {
//        if let location = location {
//            fetchPlacemark(at: location) { (retrievedPlacemark: CLPlacemark?) in
//                self.placemark = retrievedPlacemark
//            }
//        }
//    }
//        
//    private func fetchPlacemark(at location: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void ) {
//        // Use restaurant's location.
//        if let location = self.location2 {
//            let geocoder = CLGeocoder()
//            
//            // Look up the location and pass it to the completion handler
//            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
//                if error == nil {
//                    let firstLocation = placemarks?[0]
//                    completionHandler(firstLocation)
//                }
//                else {
//                    // An error occurred during geocoding.
//                    completionHandler(nil)
//                }
//            })
//        } else {
//            // Restaurant has no coordinate set
//            completionHandler(nil)
//        }
//    }
}

// MARK: - Display Information
extension Restaurant {
    var locationDescription: String {
        "\(city), \(state)"
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


