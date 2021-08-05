//
//  Placemark.swift
//  Placemark
//
//  Created by Hunter Holland on 7/25/21.
//

import MapKit
import SwiftUI

/// A wrapper of `MKPlacemark`, a user-friendly description of a location on a map
//struct Placemark: Identifiable {
//    let placemark: MKPlacemark
//    
//    init() {
//        self.placemark = MKMapItem.forCurrentLocation().placemark
//    }
//    
//    init(placemark: MKPlacemark) {
//        self.placemark = placemark
//    }
//    
//    init(placemark: CLPlacemark) {
//        self.init(placemark: MKPlacemark(placemark: placemark))
//    }
//    
//    init(mapItem: MKMapItem) {
//        self.placemark = mapItem.placemark
//    }
//    
//    init(coordinate: CLLocationCoordinate2D) {
//        self.placemark = MKPlacemark(coordinate: coordinate)
//    }
//    
//    init(latitude: Double, longitude: Double) {
//        self.init(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
//    }
//    
//    var id: UUID {
//        return UUID()
//    }
//    
//    var name: String {
//        self.placemark.name ?? ""
//    }
//    
//    var address: String {
//        self.placemark.title ?? ""
//    }
//    
//    var coordinate: CLLocationCoordinate2D {
//        self.placemark.coordinate
//    }
//    
//    var city: String {
//        self.placemark.locality ?? ""
//    }
//    
//    var state: String {
//        self.placemark.administrativeArea ?? ""
//    }
//    
//    var country: String {
//        self.placemark.country ?? ""
//    }
//    
//    func distance(to other: Placemark) -> Double? {
//        guard let location1 =  self.placemark.location else { return nil }
//        guard let location2 = other.placemark.location else { return nil }
//        
//        return location1.distance(from: location2)
//    }
//}

// MARK: - Placemark
final class Placemark: MKPlacemark, Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    
    var address: String {
        title ?? ""
    }
    
    var city: String {
        locality ?? ""
    }
    
    var state: String {
        administrativeArea ?? ""
    }
}

// MARK: - Location
final class Location: ObservableObject {
    @Published var address: String
    var placemark: Placemark?
    
    init(address: String = "", placemark: Placemark? = nil) {
        self.address = address
        self.placemark = placemark
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.address = try container.decode(String.self, forKey: .address)
        self.placemark = try container.decode(Placemark.self, forKey: .placemark)
    }
    
    convenience init(placemark: CLPlacemark) {
        self.init(address: "", placemark: Placemark(placemark: placemark))
    }
    
    convenience init(mapItem: MKMapItem) {
        self.init(placemark: mapItem.placemark)
    }
    
    func getPlacemarkFromAddress(onCompletion: @escaping (Result<Placemark, RestaurantCreationError>) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.address) { (placemarks, error) in
            if let placemarks = placemarks {
                // successful geocode
                let placemark = Placemark(placemark: placemarks[0])
                onCompletion(.success(placemark))
            } else if error != nil {
                // geocoder failed
                onCompletion(.failure(.AddressError(type: .NoPlacemarkFoundError)))
            } else {
                // this shouldn't be possible
                onCompletion(.failure(.AddressError(type: .UnknownError)))
            }
        }
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.placemark == rhs.placemark // TODO: ENSURE THAT THIS DOES ENSURE UNIQUENESS
    }
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
                    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    lazy var locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
}

extension CLLocation {
    convenience init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
                                              
