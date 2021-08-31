//
//  PlacemarkAnnotation.swift
//  PlacemarkAnnotation
//
//  Created by Hunter Holland on 7/25/21.
//

import UIKit
import MapKit

final class LocationAnnotation: NSObject, MKAnnotation, Identifiable {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: Coordinate) {
        self.title = nil
        self.coordinate = coordinate.locationCoordinate
    }
    
    init?(placemark: Placemark) {
        if let coordinate = placemark.coordinate {
            self.title = placemark.name
            self.coordinate = coordinate.locationCoordinate
            return
        }
        
        return nil
    }
}

