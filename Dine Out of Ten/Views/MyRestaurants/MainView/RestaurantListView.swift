//
//  RestaurantListView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/28/20.
//

import SwiftUI

struct RestaurantListView: View {
    @EnvironmentObject var user: User
    
    @State private var sheetSelection: DataEntryView? = nil
    
    var body: some View {
        Form {
            ForEach(user.restaurants) { restaurant in
                NavigationLink(destination: UserRestaurantPage2(restaurant: restaurant)) {
                    RestaurantRow(restaurant: restaurant)
                }
            }
            .onDelete(perform: removeItems)
        }
        .navigationBarTitle(Text("My Restaurants"), displayMode: .large)
        .task {
            do {
                user.loadData()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        self.sheetSelection = .NewItemView
                            },
                           label:  { Text("Add Menu Item")
                                     Image(systemName: "note.text.badge.plus")
                            
                           })
                    Button(action: {
                        self.sheetSelection = .NewRestaurantView
                    },
                           label: { Text("Add Restaurant")
                                    Image(systemName: "house") }
                    )
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.callout)
                        .foregroundColor(.accentColor)
                }
                .padding(.leading)
                
                Menu {
                    Button(action: {
                        self.sheetSelection = .NewItemView
                            },
                           label:  { Text("Add Menu Item")
                                     Image(systemName: "note.text.badge.plus")
                            
                           })
                    Button(action: {
                            self.sheetSelection = .NewRestaurantView
                    },
                           label: { Text("Add Restaurant")
                                    Image(systemName: "house") }
                    )
                } label: {
                    Image(systemName: "plus")
                        .font(.callout)
                        .foregroundColor(.accentColor)
                }
                .padding(.leading)
            }
        }
        .sheet(item: $sheetSelection) { selectedTarget in
            switch selectedTarget {
            case .NewItemView:
                NewMenuItemView()
            case .NewRestaurantView:
                NewRestaurantBySearch()
            default:
                EmptyView()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        user.restaurants.remove(atOffsets: offsets)
    }
}

struct Restaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(User(testOrdersPerItem: 10))
    }
}


