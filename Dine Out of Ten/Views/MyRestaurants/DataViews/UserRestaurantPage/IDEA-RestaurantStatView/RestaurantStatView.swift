//
//  RestaurantStatView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/30/20.
//

import SwiftUI

struct RestaurantStatView: View {
    var restaurant: Restaurant
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                StatViewItem(type: .RestaurantRank, restaurant: restaurant)
                
                Divider()
                
                StatViewItem(type: .BestOrder, restaurant: restaurant)
                
                Divider()
                
                StatViewItem(type: .WorstOrder, restaurant: restaurant)
                
                Divider()
                
                StatViewItem(type: .LoggedOrders, restaurant: restaurant)
            }
        }
    }
}

//struct RestaurantDashboardV2_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRestaurantPage(restaurant: userRestaurants[0])
//    }
//}
