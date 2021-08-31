//
//  UserRestaurantPage.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/29/20.
//

import SwiftUI

struct UserRestaurantPage: View {
    @EnvironmentObject var user: User
    
    @ObservedObject var restaurant: Restaurant
    
    @State private var sheetSelection: DataEntryView? = nil
    @State private var addTagViewShowing: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                mapView
                
                RestaurantHeaderView(addTagViewShowing: $addTagViewShowing)
                    .padding(.horizontal)
                    
                HStack {
                    Text("My Items")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: {
                        // show filter menu
                    }, label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .padding(.trailing)
                            .foregroundColor(.accentColor)
                            .font(.title3.weight(.regular))
                    }).buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                ForEach(restaurant.menuItems) { menuItem in
                    NavigationLink(destination: UserMenuItemPage(item: menuItem)) {
                        MenuItemRow(item: menuItem)
                    }
                    .modifier(ListRowModifier())
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.primary)
                }
                .padding(.horizontal)
            }
            .navigationTitle(restaurant.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.sheetSelection = .NewItemView
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    })
                }
            }
            .sheet(item: $sheetSelection) { selectedTarget in
                switch selectedTarget {
                case .NewItemView:
                    NewMenuItemView(for: restaurant)
                default:
                    EmptyView()
                }
            }
            
//            if addTagViewShowing { AddTagView(item: restaurant) }
        }
    }
    
    private var mapView: some View {
        restaurant.placemark.coordinate.map(RestaurantMapView.init)
            .ignoresSafeArea(edges: .top)
            .frame(height: 170)
    }
}

struct RestaurantPage_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage(restaurant: Restaurant.example)
    }
}
