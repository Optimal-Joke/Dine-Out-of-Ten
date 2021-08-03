//
//  MenuItemRow.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct MenuItemRow: View {
    let item: MenuItem
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.body)
                    .padding(.vertical, 10)
                
                Spacer()
                
                Text("\(item.averageRating.description)")
                    .font(.title2)
                
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
            }
//            Divider().offset(y: -2)
        }
    }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage(restaurant: Restaurant.example)
    }
}
