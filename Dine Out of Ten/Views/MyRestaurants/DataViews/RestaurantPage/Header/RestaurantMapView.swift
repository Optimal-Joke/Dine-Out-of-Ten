//
//  RestaurantMapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import SwiftUI
import MapKit

struct RestaurantMapView: View {
    var restaurant: Restaurant
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .zoom)
    }
}

struct RestaurantMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantMapView(restaurant: Restaurant.example)
    }
}
