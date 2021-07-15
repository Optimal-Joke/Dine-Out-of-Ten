//
//  NavigationTabBar.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/29/20.
//

import SwiftUI
import MapKit

struct NavigationTabBar: View {
    
    private enum Tab: Hashable {
        case myRestaurants
        case map
        case settings
    }
    
    @State private var selectedTab: Tab = .myRestaurants
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    RootView()
                        .tag(0)
                        .tabItem {
                            Text("My Restaurants")
                            Image(systemName: "house.fill")
                        }
                    MapView()
                        .tag(1)
                        .tabItem {
                            Text("Map")
                            Image(systemName: "map.fill")
                        }
                    SettingsView()
                        .tag(2)
                        .tabItem {
                            Text("Settings")
                            Image(systemName: "gearshape.fill")
                        }
                })
    }
}

struct NavigationTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabBar()
    }
}
