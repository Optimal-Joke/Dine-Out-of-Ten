//
//  Location.swift
//  Location
//
//  Created by Hunter Holland on 8/5/21.
//

import MapKit

// MARK: - Placemark
final class Placemark: Identifiable {
    /// A unique identifier for the placemark.
    var id = UUID()
    /// The name of the placemark.
    public var name: String?
    /// The coordinate object containing latitude and longitude information.
    public var coordinate: Coordinate?
    /// The address of the placemark, as set by the user.
    public var address: String? {
        didSet {
            if address == "" {
                address = nil
            }
        }
    }
    /// The abbreviated country or region name.
    public var isoCountryCode: String?
    /// The name of the country or region associated with the placemark.
    public var country: String?
    /// The postal code associated with the placemark.
    public var postalCode: String?
    /// The state or province associated with the placemark.
    public var administrativeArea: String?
    /// Additional administrative area information for the placemark.
    public var subAdministrativeArea: String?
    /// The city associated with the placemark.
    public var locality: String?
    /// Additional city-level information for the placemark.
    public var subLocality: String?
    /// The street address associated with the placemark.
    public var thoroughfare: String?
    /// Additional street-level information for the placemark.
    public var subThoroughfare: String?
//    /// The geographic region associated with the placemark.
//    var region: CLRegion?
    /// The time zone associated with the placemark.
    public var timeZone: TimeZone?
    
    /// The location object containing latitude and longitude information.
    public var location: CLLocation? {
        if let coordinate = self.coordinate {
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        } else {
            return nil
        }
    }
    
    /// Creates an empty placemark object with all values set to nil. 
    public init() { }
    
    /// Creates a new placemark object using the values of the given placemark.
    public init(placemark: CLPlacemark) {
        self.name = placemark.name
        self.coordinate = Coordinate(location: placemark.location)
        self.isoCountryCode = placemark.isoCountryCode
        self.country = placemark.country
        self.postalCode = placemark.postalCode
        self.administrativeArea = placemark.administrativeArea
        self.subAdministrativeArea = placemark.subAdministrativeArea
        self.locality = placemark.locality
        self.subLocality = placemark.subLocality
        self.thoroughfare = placemark.thoroughfare
        self.subThoroughfare = placemark.subThoroughfare
        self.timeZone = placemark.timeZone
    }
    
    /// Creates a new placemark object using the given coordinate.
    public init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
    
    /// Creates a new placemark object using the given latitude and longitude values.
    public convenience init(latitude: Double, longitude: Double) {
        self.init(coordinate: Coordinate(latitude: latitude, longitude: longitude))
    }
    
    /// Creates a new placemark object using the placemark of the given map item.
    public convenience init(mapItem: MKMapItem) {
        self.init(placemark: mapItem.placemark)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.isoCountryCode = try container.decodeIfPresent(String.self, forKey: .isoCountryCode)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        self.administrativeArea = try container.decodeIfPresent(String.self, forKey: .administrativeArea)
        self.subAdministrativeArea = try container.decodeIfPresent(String.self, forKey: .subAdministrativeArea)
        self.locality = try container.decodeIfPresent(String.self, forKey: .locality)
        self.subLocality = try container.decodeIfPresent(String.self, forKey: .subLocality)
        self.thoroughfare = try container.decodeIfPresent(String.self, forKey: .thoroughfare)
        self.subThoroughfare = try container.decodeIfPresent(String.self, forKey: .subThoroughfare)
        self.timeZone = try container.decodeIfPresent(TimeZone.self, forKey: .timeZone)
    }
        
    /// Geocodes the current value of the placemark's address to populate the placemark's other properties.
    func configureFromAddress(onCompletion: @escaping (Result<Placemark, RestaurantCreationError>) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.address ?? "") { (placemarks, error) in
            if let placemarks = placemarks {
                // successful geocode
                let newPlacemark = Placemark(placemark: placemarks[0])
                self.update(using: newPlacemark)
                onCompletion(.success(newPlacemark))
            } else if error != nil {
                // geocoder failed
                onCompletion(.failure(.AddressError(type: .NoPlacemarkFoundError)))
            } else {
                // this shouldn't be possible
                onCompletion(.failure(.AddressError(type: .UnknownError)))
            }
        }
    }
    
//    static func from(address: String) async -> Placemark2 {
//
//    }
    
    private func update(using placemark: Placemark) {
        self.name = placemark.name
        self.coordinate = placemark.coordinate
        self.address = placemark.address
        self.isoCountryCode = placemark.isoCountryCode
        self.country = placemark.country
        self.postalCode = placemark.postalCode
        self.administrativeArea = placemark.administrativeArea
        self.subAdministrativeArea = placemark.subAdministrativeArea
        self.locality = placemark.locality
        self.subLocality = placemark.subLocality
        self.thoroughfare = placemark.thoroughfare
        self.subThoroughfare = placemark.subThoroughfare
        self.timeZone = placemark.timeZone
    }
}

extension Placemark: Equatable {
    static func == (lhs: Placemark, rhs: Placemark) -> Bool {
        lhs.coordinate == rhs.coordinate || lhs.address == rhs.address
    }
}

// MARK: - Coordinate
struct Coordinate: Codable, Equatable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(location: CLLocation?) {
        if let location = location {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        } else {
            return nil
        }
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocation {
    convenience init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

