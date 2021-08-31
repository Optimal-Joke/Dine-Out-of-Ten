//
//  TopBar.swift
//  TopBar
//
//  Created by Hunter Holland on 7/31/21.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var restaurant: Restaurant
    var topEdge: CGFloat
    @Binding var offset: CGFloat
    var maxHeight: CGFloat
    
    @State private var showEditTagsView = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .font(.largeTitle.bold())
                            .truncationMode(.middle)
                        
                        Text(restaurant.locationDescription)
                            .font(.body.weight(.medium))
                            .opacity(0.8)
                    }
                    
                    Spacer()
                    
                    RestaurantRatingDisplay()
                        .foregroundColor(.white)
                }
                
                ItemTagListView(for: restaurant, size: .small, trailingButtonMode: .dynamic(primaryLabel: "Edit Tags...", secondaryLabel: "Add Tags...")) {
                    showEditTagsView = true
                }
            }
            .frame(height: geo.size.height, alignment: .bottom)
            .opacity(getOpacity())
        }
        .padding()
        .padding(.bottom)
        .halfSheet(showSheet: $showEditTagsView) {
            EditTagView(item: restaurant)
                .environmentObject(user)
        }
    }
    
    private var mapView: some View {
        restaurant.placemark.coordinate.map(RestaurantMapView.init)
            .frame(maxHeight: maxHeight / 2 - topEdge)
            .cornerRadius(20)
            .opacity(getMapOpacity())
    }
    
    // calculating opacity
    private func getOpacity() -> CGFloat {
        let progress = -(90 + offset + topEdge) / 40
        
        let opacity = 1 - progress
        
        return -offset > (90 + topEdge) ? opacity : 1
    }
    
    private func getMapOpacity() -> CGFloat {
        let progress = -offset / 30
        
        let opacity = 1 - progress
        
        return offset < 0 ? opacity : 1
    }
    
//    private func getMapPadding() -> CGFloat? {
//        let progress = offset / 70
//
//        let padding = 1 - progress * 35
//
//        return offset < 0 ? padding : 0
//    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TopBar(topEdge: 0, offset: .constant(0), maxHeight: 500)
                .environmentObject(Restaurant.example)
                .environmentObject(User.example)
                .background(Color.offWhite)
            
            Spacer()
        }
    }
}
