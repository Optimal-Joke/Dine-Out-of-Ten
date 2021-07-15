//
//  NewRestaurantView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/25/20.
//

import SwiftUI

struct NewRestaurantView: View {
    @State var restaurantName = ""
    @State var restaurantLocation = ""
    @State var test = false
    
    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Restaurant Name", text: $restaurantName)
                    TextField("Location", text: $restaurantLocation)
                }
                Section(header: Text("Menu Information")) {
                    Toggle(isOn: $test, label: {
                                Text("Add Menu Item with Restaurant")
                            })
                }
            }
            .navigationTitle(Text("New Restaurant"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() },
                           label:  { Text("Cancel") }
                    ).padding(.bottom, 50)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let newRest = Restaurant(name: restaurantName)
                        user.restaurants.append(newRest)
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }
    
//    func createRestaurant(called name: String) {
//        let new = Restaurant(name: name)
////        userRestaurants.append(new)
//    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView()
    }
}
