//
//  RestaurantGroupView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct RestaurantGroupView: View {
    @EnvironmentObject var user: User
    
//    @State private var restaurantGroups = [MenuItem(name: "Test", restaurant: Restaurant(name: "TestRest1"))]
    @State private var isShowing = false
    
    var body: some View {
        Form {
            NavigationLink(destination: RestaurantListView(), isActive: $isShowing) {
                GroupRow(label: "All", icon: "plus")
            }
            NavigationLink(destination: RestaurantListView(), isActive: $isShowing) {
                GroupRow(label: "All", icon: "plus")
            }
        }
        .navigationBarTitle(Text("Groups"), displayMode: .large)
        .navigationBarBackButtonHidden(true)
    }
}

struct RestaurantGroups_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
