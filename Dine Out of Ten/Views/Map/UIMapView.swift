//
//  UIMapView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/28/20.
//

import SwiftUI
import MapKit

struct UIMapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        view.mapType = .standard
        view.showsCompass = true
        view.showsScale = true
        view.showAnnotations(annotations, animated: false)
        
        if annotations.count != view.annotations.count {
                view.removeAnnotations(view.annotations)
                view.addAnnotations(annotations)
            }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: UIMapView

        init(_ parent: UIMapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}
