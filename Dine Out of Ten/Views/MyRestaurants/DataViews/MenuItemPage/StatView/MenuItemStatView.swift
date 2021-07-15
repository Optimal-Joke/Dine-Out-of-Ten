//
//  MenuItemStatView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import SwiftUI

struct MenuItemStatView: View {
    var item: MenuItem
    
    var body: some View {
        VStack {
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    MenuItemStatViewItem(type: .itemRanking(value: item.rank, outOf: item.restaurant.uniqueOrders), item: item)
                    
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
}

struct MenuItemStatView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemPage(item: MenuItem.example)
    }
}
