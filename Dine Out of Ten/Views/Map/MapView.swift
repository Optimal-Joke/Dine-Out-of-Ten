//
//  MapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        ZStack {
            UIMapView(centerCoordinate: $centerCoordinate, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.accentColor.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
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
