//
//  RestaurantDashboard.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/30/20.
//

import SwiftUI

struct RestaurantDashboard: View {
    var restaurant: Restaurant
    
    private let spacerSize: CGFloat = 25
    var body: some View {
        VStack {
            HStack {
                DashboardWidget(type: .BestOrder, restaurant: restaurant)
                Spacer(minLength: spacerSize)
                DashboardWidget(type: .WorstOrder, restaurant: restaurant)
            }
            
            Spacer(minLength: spacerSize)
            
            HStack {
                DashboardWidget(type: .LoggedOrders, restaurant: restaurant)
                Spacer(minLength: spacerSize)
                DashboardWidget(type: .RestaurantRank, restaurant: restaurant)
            }
            
        }
//        .padding()
        .frame(maxHeight: 350)
        .frame(height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

//struct RestaurantDashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRestaurantPage(restaurant: userRestaurants[0])
//    }
//}
