//
//  OrderRow.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/16/21.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    var isExpanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(order.dateConsumed.format(dateStyle: .long))
                    .padding(.vertical, 3)
                
                Spacer()
                
                Text("\(order.rating.description)")
                    .font(.title2)
                
                Image(systemName: "chevron.up")
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .animation(.linear(duration: 0.15), value: isExpanded)
            }
            
            if isExpanded {
                HStack {
                    Text(order.notes)
                        .padding(.bottom, 10)
                        .padding(.top, 3)
                    
                    Spacer()
                }
                .transition(.opacity)
                
            }
        }
        .contentShape(Rectangle())
    }
}

//struct OrderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        UserMenuItemPage(item: MenuItem.example)
//            .environmentObject(User())
//    }
//}
