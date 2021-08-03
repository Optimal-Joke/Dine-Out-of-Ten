//
//  TopBar.swift
//  TopBar
//
//  Created by Hunter Holland on 7/31/21.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var user: User
    var restaurant: Restaurant
    var topEdge: CGFloat
    @Binding var offset: CGFloat
    var maxHeight: CGFloat
    
    @State private var showEditTagsView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            RestaurantMapView(restaurant: restaurant)
                .frame(maxHeight: maxHeight / 2 - topEdge)
                .cornerRadius(20)
                .opacity(getMapOpacity())
            
            Group {
                HStack {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .font(.largeTitle.bold())
                            .truncationMode(.middle)
                        
                        //                Text(restaurant.locationDescription)
                        Text(restaurant.locationDescription)
                            .font(.body.weight(.medium))
                            .opacity(0.8)
                    }
                    
                    Spacer()
                    
                    RestaurantRatingDisplay(restaurant: restaurant)
                        .foregroundColor(.white)
                }
                
                ItemTagListView(for: restaurant, size: .small, trailingButtonMode: .dynamic(primaryLabel: "Edit Tags...", secondaryLabel: "Add Tags...")) {
                    showEditTagsView = true
                }
            }
            .opacity(getOpacity())
        }
        .padding()
        .padding(.bottom)
        .halfSheet(showSheet: $showEditTagsView) {
            EditTagView(item: restaurant)
                .environmentObject(user)
        }
    }
    
    // calculating opacity
    private func getOpacity() -> CGFloat {
        let progress = -(130 + offset + topEdge) / 40
        
        let opacity = 1 - progress
        
        return -offset > (130 + topEdge) ? opacity : 1
    }
    
    private func getMapOpacity() -> CGFloat {
        let progress = -offset / 30
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
    
    private func getMapPadding() -> CGFloat? {
        let progress = offset / 70
        
        let padding = 1 - progress * 35
        
        return offset < 0 ? padding : 0
    }
}
