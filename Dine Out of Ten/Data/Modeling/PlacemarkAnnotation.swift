//
//  PlacemarkAnnotation.swift
//  PlacemarkAnnotation
//
//  Created by Hunter Holland on 7/25/21.
//

import UIKit
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(placemark: Placemark) {
        self.title = placemark.name
        self.coordinate = placemark.coordinate
    }
}

