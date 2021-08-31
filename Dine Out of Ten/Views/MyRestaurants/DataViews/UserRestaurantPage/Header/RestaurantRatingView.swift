//
//  RestaurantRatingView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/14/21.
//

import SwiftUI

struct RestaurantRatingDisplay: View {
    @EnvironmentObject var restaurant: Restaurant
    
    var body: some View {
        VStack {
            Text("\(restaurant.averageRating.description)")
                .font(.system(size: 42).weight(.medium))
            Text("out of 10")
                .font(.subheadline.weight(.medium))
                .opacity(0.7)
                .offset(y: -4)
        }
    }
}

struct RestaurantRatingView_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage(restaurant: Restaurant.example)
    }
}
