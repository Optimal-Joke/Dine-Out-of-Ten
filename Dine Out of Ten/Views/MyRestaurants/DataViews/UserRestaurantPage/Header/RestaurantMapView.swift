//
//  RestaurantMapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import SwiftUI
import MapKit

protocol SmallMapView: View {
    var coordinate: CLLocationCoordinate2D { get set }
    
    init(coordinate: Coordinate)
}

struct RestaurantMapView: View {
    var coordinate: Coordinate
    
    @State private var restaurantRegion = MKCoordinateRegion()
    
    init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
    
    var body: some View {
        Map(coordinateRegion: region, interactionModes: [], annotationItems: [annotation]) { item in
            MapMarker(coordinate: coordinate.locationCoordinate, tint: .red)
        }
    }
    
    private var region: Binding<MKCoordinateRegion> {
        Binding<MKCoordinateRegion>(get: {
            MKCoordinateRegion(
                center: self.coordinate.locationCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        }, set: { newRegion in
            restaurantRegion = newRegion
        })
    }
    
    private var annotation: LocationAnnotation {
        LocationAnnotation(coordinate: coordinate)
    }
}

struct RestaurantMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantMapView(coordinate: Coordinate.example)
    }
}
