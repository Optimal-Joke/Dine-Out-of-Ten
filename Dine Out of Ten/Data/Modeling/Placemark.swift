//
//  Placemark.swift
//  Placemark
//
//  Created by Hunter Holland on 7/25/21.
//

import MapKit
import SwiftUI

/// A wrapper of `MKPlacemark`, a user-friendly description of a location on a map
struct Placemark: Identifiable {
    let placemark: MKPlacemark
    
    init() {
        self.placemark = MKMapItem.forCurrentLocation().placemark
    }
    
    init(placemark: MKPlacemark) {
        self.placemark = placemark
    }
    
    init(placemark: CLPlacemark) {
        self.init(placemark: MKPlacemark(placemark: placemark))
    }
    
    init(mapItem: MKMapItem) {
        self.placemark = mapItem.placemark
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.placemark = MKPlacemark(coordinate: coordinate)
    }
    
    init(latitude: Double, longitude: Double) {
        self.init(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var address: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
    var city: String {
        self.placemark.locality ?? ""
    }
    
    var state: String {
        self.placemark.administrativeArea ?? ""
    }
    
    var country: String {
        self.placemark.country ?? ""
    }
    
    func distance(to other: Placemark) -> Double? {
        guard let location1 =  self.placemark.location else { return nil }
        guard let location2 = other.placemark.location else { return nil }
        
        return location1.distance(from: location2)
    }
}


//class MapItem: MKPlacemark {
//
////    init(placemark: MKPlacemark) {
//////        self.placemark = placemark
////    }
////
////    init(mapItem: MKMapItem) {
////        super.init()
////    }
//
//    init(latitude: Double, longitude: Double) {
//        super.init(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
//    }
//
////    public required init(from decoder: Decoder) throws {
////        super.init()
////
////
////    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//
//
//    }
//
//    var id: UUID {
//        return UUID()
//    }
//
//    override var name: String {
//        super.name ?? ""
//    }
//
//    var address: String {
//        title ?? ""
//    }
//
//    var city: String {
//        locality ?? ""
//    }
//
//    var state: String {
//        administrativeArea ?? ""
//    }
//
//    func distance(to other: MapItem) -> Double? {
//        guard let location1 = location else { return nil }
//        guard let location2 = other.location else { return nil }
//
//        return location1.distance(from: location2)
//    }
//
//}


