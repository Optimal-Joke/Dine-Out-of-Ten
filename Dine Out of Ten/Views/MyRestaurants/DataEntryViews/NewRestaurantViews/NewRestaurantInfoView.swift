//
//  NewRestaurantManual.swift
//  NewRestaurantManual
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI
import MapKit

struct NewRestaurantInfoView: View {
    private var customString: String?
    private var mapItem: MKMapItem?
    
    @State private var restaurant = Restaurant()
    
    @State private var readyToSave = false
    
    @State private var error: RestaurantCreationError?
    @State private var alertIsShowing = false
    
    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode
    
    init(using customString: String = "") {
        restaurant.name = customString
        restaurant.placemark = Placemark()
    }
    
    init(using mapItem: MKMapItem) {
        restaurant.name = mapItem.name ?? ""
        restaurant.address = mapItem.placemark.title ?? ""
        restaurant.placemark = Placemark(mapItem: mapItem)
        self.readyToSave = true
    }
    
    var body: some View {
        VStack {
            Group {
                TextField("Add restaurant name", text: $restaurant.name)
                    .font(.title2)
                    
                TextField("Address", text: $restaurant.address)
                    .font(.subheadline)
            }
            
            Divider()
            
            VStack(alignment: .trailing) {
                if restaurant.tags.count == 0 {
                    HStack {
                        Text("Choose a tag...")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    ItemTagListView(for: restaurant, size: .small)
                }
            }
            .padding(.vertical)
            
            Rectangle()
                .foregroundColor(.accentColor)
                .opacity(0.20)
                .frame(width: UIScreen.main.bounds.size.width, height: 20)
            
            VStack {
                UserTagListView(for: restaurant)
                    .frame(minHeight: 100, alignment: .top)
                                
                NavigationLink("Create New Tag...", destination: NewTagView(item: restaurant, type: .pageView))
            }
            
            Rectangle()
                .foregroundColor(.accentColor)
                .opacity(0.20)
                .frame(width: UIScreen.main.bounds.size.width, height: 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle(Text("New Restaurant"))
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveRestaurant()
                },
                   label:  { Text("Add") }
                )
            }
        }
        .alert(isPresented: $alertIsShowing) {
            let error: RestaurantCreationError = error ?? RestaurantCreationError.UnknownError
            
            switch error {
            case .AddressError:
                return error.alert(primaryButton: Alert.Button.default(Text("Save Anyway"), action: saveRestaurantWithoutAddress), secondaryButton: Alert.Button.cancel(Text("Add Address")))
            default:
                return error.alert()
            }
        }
    }
    
    private func getPlacemark(from address: String,
                              onCompletion: @escaping (Result<Placemark, RestaurantCreationError>) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                // successful geocode
                let placemark = Placemark(placemark: MKPlacemark(placemark: placemarks[0]))
                onCompletion(.success(placemark))
            } else if error != nil {
                // geocoder failed
                onCompletion(.failure(.AddressError(type: .NoPlacemarkFoundError)))
            } else {
                // this shouldn't be possible
                onCompletion(.failure(.AddressError(type: .UnknownError)))
            }
        }
    }
    
    private func addPlacemarkToRestaurant() {
        guard restaurant.address != "" else {
            error = RestaurantCreationError.AddressError(type: .NoAddressError)
            alertIsShowing = true
            return
        }
        
        getPlacemark(from: restaurant.address) { result in
            switch result {
            case .success(let retrievedPlacemark):
                // placemark was successfully retrieved
                restaurant.placemark = retrievedPlacemark
                user.restaurants.append(restaurant)
                self.presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                // an error occurred
                self.error = error
                self.alertIsShowing = true
            }
        }
    }
    
    private func saveRestaurantWithoutAddress() {
        // assign empty placemark
        restaurant.placemark = Placemark()
        readyToSave = true
        
        saveRestaurant()
    }
    
    private func saveRestaurant() {
        guard restaurant.name != "" else {
            error = RestaurantCreationError.NoNameError
            alertIsShowing = true
            return
        }
        
        guard !user.restaurants.contains(restaurant) else {
            error = RestaurantCreationError.RestaurantAlreadyExistsError
            alertIsShowing = true
            return
        }
        
        if readyToSave {
            user.restaurants.append(restaurant)
            self.presentationMode.wrappedValue.dismiss()
        } else {
            // for places with a user-entered address
            addPlacemarkToRestaurant()
        }
    }
}

struct NewRestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantInfoView(using: "Test Restaurant")
            .environmentObject(User(testOrdersPerItem: 10))
    }
}
