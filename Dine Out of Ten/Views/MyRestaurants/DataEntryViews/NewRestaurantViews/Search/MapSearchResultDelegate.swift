//
//  MapSearchResultDelegate.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/23/21.
//

import SwiftUI
import MapKit


// MARK: MapSearchResultDelegate
class MapSearchResultDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var searchQuery: String = ""
    
    /// For showing alert when location is trying to be accessed but user has denied permission
    @Published var permissionDenied = false
    
    /// The region around the user.
    @Published var region: MKCoordinateRegion!
    
    @Published var places: [MKMapItem] = []
    
    private var localSearch: MKLocalSearch!
    
    var isSearching: Bool {
        localSearch != nil && localSearch!.isSearching
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // check user location permissions
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied = true
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .authorizedAlways:
            manager.requestLocation()
        default:
            print("This shouldn't happen!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    /// Adjusts the user's local region based on their current location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print(location.coordinate)
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func searchNearby() {
        self.places = []
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.pointOfInterestFilter = MKPointOfInterestFilter(including: [.bakery, .brewery, .cafe, .nightlife, .restaurant, .winery])
        searchRequest.resultTypes = MKLocalSearch.ResultType([.pointOfInterest])
        search(using: searchRequest)
    }
    
    func searchWithCurrentQuery() {
        self.places = []
        
        self.search(for: searchQuery)
    }
    
    /// Creates and configures an instance of `MKLocalSearch.Request`.
    /// - Parameter queryString: A search string from the text the user entered into `SearchBar`
    private func search(for queryString: String?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
        searchRequest.pointOfInterestFilter = MKPointOfInterestFilter(including: [.bakery, .brewery, .cafe, .nightlife, .restaurant, .winery])
        searchRequest.resultTypes = MKLocalSearch.ResultType([.pointOfInterest])
        search(using: searchRequest)
    }
    
    private func search(using searchRequest: MKLocalSearch.Request) {
        localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch.start { (response, _) in
            guard let result = response else { return }
            
            self.places = result.mapItems
            
            print("""
Search Query: \(self.searchQuery)
Top result: \(self.places[0].name ?? "No Name"), \(self.places[0].placemark.title ?? "No Address")

""")
        }
    }
}

extension MKMapItem: Identifiable { }

