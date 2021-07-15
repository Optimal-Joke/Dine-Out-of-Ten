//
//  RestaurantRatingView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/14/21.
//

import SwiftUI

struct RestaurantRatingDisplay: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack {
            Text("\(restaurant.averageRating.description)")
                .font(.system(size: 42))
            Text("out of 10")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct RestaurantRatingView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantPage(restaurant: Restaurant.example)
    }
}
