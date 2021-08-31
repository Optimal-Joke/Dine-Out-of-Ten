//
//  RootView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct RootView: View {
    @StateObject var user = User(testOrdersPerItem: 10)
//    @StateObject var restaurants =
    
    var body: some View {
        NavigationView {
//            RestaurantGroupView()
            RestaurantListView()
        }
        .environmentObject(user)
//        .environmentObject(restaurants)
        .onAppear(perform: user.loadData)
    }
    
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
