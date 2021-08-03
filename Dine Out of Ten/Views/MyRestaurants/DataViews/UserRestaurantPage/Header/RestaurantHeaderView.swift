//
//  RestaurantHeaderView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct RestaurantHeaderView: View {
    var restaurant: Restaurant
    
    @Binding var addTagViewShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    Text(restaurant.locationDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                RestaurantRatingDisplay(restaurant: restaurant)
            }
                        
            ItemTagListView(for: restaurant, trailingButtonMode: .dynamic(primaryLabel: "Edit Tags...", secondaryLabel: "Add Tags...")) {
                addTagViewShowing = true
            }
            
            Divider()
        }
        .halfSheet(showSheet: $addTagViewShowing) {
            Text("Edit Τag View")
        }
    }
}

struct RestaurantPageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage(restaurant: Restaurant.example)
    }
}
