//
//  MapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    
    // tracking whether or not to show place details
    @State var selectedPlace: MKPointAnnotation?
    @State var showingPlaceDetails = false
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            UIMapView(centerCoordinate: $centerCoordinate, annotations: locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.accentColor.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
