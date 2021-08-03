//
//  MenuItemStatView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import SwiftUI

struct MenuItemStatView: View {
    @EnvironmentObject var user: User
    var item: MenuItem
    
    var body: some View {
        VStack {
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    MenuItemStatViewItem(type: .itemRanking(value: itemRank, outOf: restaurant.uniqueOrders), item: item)
                    
                    Divider()
                    
                    MenuItemStatViewItem(type: .averageRating(value: item.averageRating), item: item)
                    
                    Divider()
                    
                    MenuItemStatViewItem(type: .dateOfLastRating(value: item.lastConsumed), item: item)
                    
                    Divider()
                    
                    MenuItemStatViewItem(type: .mostRecentPrice(value: item.priceNow), item: item)
                    
                    Divider()
                    
                    MenuItemStatViewItem(type: .timesRated(value: item.numOrders), item: item)
                }
                .fixedSize()
            }
            
            Divider()
        }
    }
    
    var restaurant: Restaurant {
        user.getRestaurant(withID: item.restaurantID)
    }
    
    var itemRank: Int {
        restaurant.menuItems.filter { $0.averageRating > item.averageRating }.count + 1
    }
}

struct MenuItemStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserMenuItemPage(item: MenuItem.example)
    }
}
