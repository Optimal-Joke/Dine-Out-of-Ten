//
//  NewRestaurantInfoView.swift
//  NewRestaurantInfoView
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI
import MapKit

struct NewRestaurantInfoView: View {
    private var customString: String?
    private var mapItem: MKMapItem?
    
    @ObservedObject private var restaurant = Restaurant()
    
    @State private var performChecksOnSave = true
    
    @State private var error: RestaurantCreationError?
    @State private var alertIsShowing = false
    
    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode
    
    init(using customString: String = "") {
        restaurant.name = customString
    }
    
    init(using mapItem: MKMapItem) {
        restaurant.name = mapItem.name ?? ""
        restaurant.placemark = Placemark(mapItem: mapItem)
        restaurant.placemark.address = mapItem.placemark.title ?? ""
    }
    
    var body: some View {
        VStack {
            Group {
                TextField("Add restaurant name", text: $restaurant.name)
                    .font(.title2)
                    
                TextField("Address", text: $restaurant.placemark.address ?? "")
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
                    ItemTagListView(for: restaurant, size: .medium, deletable: true, trailingButtonMode: .stable(label: "")) {
                        
                    }
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
                return error.alert(primaryButton: Alert.Button.default(Text("Save Anyway"), action: {
                    performChecksOnSave = false
                    configurePlacemark()
                    saveRestaurant()
                }), secondaryButton: Alert.Button.cancel(Text("Add Address")))
            default:
                return error.alert()
            }
        }
    }
    
    private func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func saveRestaurant() {
        if performChecksOnSave {
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
            
            // check for address
            guard !restaurant.placemark.address.isBlank else {
                error = RestaurantCreationError.AddressError(type: .NoAddressError)
                alertIsShowing = true
                return
            }
        }
        
        user.addRestaurant(restaurant)
        user.save()
        dismissView()
    }
    
    private func configurePlacemark() {
        restaurant.placemark.configureFromAddress { result in
            switch result {
            case .success(_):
                // placemark was successfully updated
                saveRestaurant()
            case .failure(let error):
                // an error occurred
                self.error = error
                self.alertIsShowing = true
            }
        }
    }
}

struct NewRestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantInfoView(using: "Test Restaurant")
            .environmentObject(User(testOrdersPerItem: 10))
    }
}
