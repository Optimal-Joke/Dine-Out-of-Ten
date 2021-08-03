//
//  RestaurantInfoPage.swift
//  RestaurantInfoPage
//
//  Created by Hunter Holland on 7/26/21.
//

import SwiftUI
import MapKit
import Contacts

struct RestaurantInfoPage: View {
    var mapItem: MKMapItem
    
    var body: some View {
        NavigationView {
            VStack {
                RestaurantMapView(restaurant: .example)
                    .cornerRadius(20)
                    .padding()
                    
                    .frame(height: UIScreen.main.bounds.height / 4)
                    
                
                Text(mapItem.phoneNumber ?? "No Phone Number")
                Text("Hello World")
                
                Spacer()
            }
            .navigationBarTitle(Text(mapItem.name ?? "No Name"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var placemark: MKPlacemark {
        mapItem.placemark
    }
}

//struct RestaurantInfoPage_Previews: PreviewProvider {
//    static let address = CNMutablePostalAddress()
//    static let coordinate = CLLocationCoordinate2D(latitude: 40.807072, longitude: -73.946301)
//
//    static var previews: some View {
//        address.postalCode = "10027"
//        address.city = "New York"
//        address.state = "NY"
//        address.street = "West 124th Street"
//        address.subLocality = "100"
//
//        let placemark = MKPlacemark(coordinate: coordinate, postalAddress: address)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Harlem Shake"
//        mapItem.phoneNumber = "+1 (212) 222-8300"
//        mapItem.url = URL(string: "harlemshakenyc.com")
//        mapItem.pointOfInterestCategory = MKPointOfInterestCategory.restaurant
//
//
//        return RestaurantInfoPage(mapItem: mapItem)
//    }
//
////    private func getPlacemark(from address: String,
////                              completionHandler: @escaping (MKPlacemark?, RestaurantCreationError?)-> Void ) {
////        let geocoder = CLGeocoder()
////        geocoder.geocodeAddressString(address) { (placemarks, error) in
////            // geocoder search failed
////            guard error == nil else {
////                completionHandler(nil, RestaurantCreationError.AddressError(type: .NoPlacemarkFoundError))
////                return
////            }
////
////            if placemarks?.isEmpty == false {
////                let placemark = MKPlacemark(placemark: placemarks![0])
////
////                completionHandler(placemark, nil)
////                return
////            }
////
////            completionHandler(nil, RestaurantCreationError.AddressError(type: .NoPlacemarkFoundError))
////        }
////    }
//
////    private func placemark(from address: String) -> MKPlacemark? {
////        var placemark: MKPlacemark?
////
////        getPlacemark(from: address) { (retrievedPlacemark, error) in
////            // placemark was successfully retrieved
////            if let retrievedPlacemark = retrievedPlacemark {
////                placemark = retrievedPlacemark
////                return
////            }
////
////            placemark = nil
////        }
////
////        return placemark
////    }
//}
