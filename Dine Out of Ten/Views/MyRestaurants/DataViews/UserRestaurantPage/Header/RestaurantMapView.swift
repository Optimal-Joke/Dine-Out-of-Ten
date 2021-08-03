//
//  RestaurantMapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import SwiftUI
import MapKit

struct RestaurantMapView: View {
    var placemark: Placemark?
    
    @State private var restaurantRegion = MKCoordinateRegion()
    
    init(restaurant: Restaurant) {
        self.placemark = restaurant.placemark
    }
    
    var body: some View {
        if let placemark = placemark {
            let region = Binding<MKCoordinateRegion>(get: {
                MKCoordinateRegion(
                    center: placemark.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                )
            }, set: { newRegion in
                restaurantRegion = newRegion
            })
            
            Map(coordinateRegion: region, interactionModes: [], annotationItems: [placemark]) { item in
                MapPin(coordinate: placemark.coordinate, tint: .red)
            }
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
        }
    }
}

struct RestaurantMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantMapView(restaurant: Restaurant.example)
    }
}
