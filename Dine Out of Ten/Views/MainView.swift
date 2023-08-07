//
//  NavigationTabBar.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/29/20.
//

import SwiftUI
import MapKit

struct MainView: View {
    var body: some View {
        TabView {
            RootView()
                .tabItem {
                    Label("My Restaurants", systemImage: "house.fill")
                }
    
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
    
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
