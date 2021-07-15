//
//  RestaurantRow.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/27/20.
//

import Foundation
import SwiftUI

struct RestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.title3)
                Text(restaurant.city)
                    .font(.subheadline)
            }
            Spacer()
            Text("\(restaurant.averageRating.description)/10")
                .font(.title2)
        }
    }
}

struct RestaurantRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
    }
}
