//
//  CoordinateToPlacemark.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import Foundation
import MapKit

struct Coordinates: Hashable, Codable {
    var lat: Double
    var long: Double
    }

let home = Coordinates(lat: 40.915283, long: -73.971697)

func convertToPlacemark(coordinate: Coordinates) -> MKPlacemark {
    let coreLocationPoint = CLLocationCoordinate2D(latitude: coordinate.lat,
                                                   longitude: coordinate.long)
    let placemark = MKPlacemark(coordinate: coreLocationPoint)
    return placemark
}
