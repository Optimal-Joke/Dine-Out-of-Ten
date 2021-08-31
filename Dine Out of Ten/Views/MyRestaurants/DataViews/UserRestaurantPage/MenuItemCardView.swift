//
//  MenuItemCardView.swift
//  MenuItemCardView
//
//  Created by Hunter Holland on 7/27/21.
//

import SwiftUI

struct MenuItemCardView: View {
    var item: MenuItem
    @EnvironmentObject var restaurant: Restaurant
    
    @State private var tapped = false
    @State private var navigateToPage = false
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
//            NavigationLink(destination: UserMenuItemPage(item: item), isActive: $navigateToPage) { EmptyView() }
            
            NavigationLink(isActive: $navigateToPage) {
                UserMenuItemPage(item: item)
                    .environmentObject(restaurant)
            } label: {
                EmptyView()
            }
            
            HStack(spacing: 15) {
                VStack(spacing: 15) {
                    Text(item.name)
                        .font(.body.weight(.medium))
                    
                    
                }
                
                Spacer()
                
                Text(item.averageRating.description)
                    .font(.system(size: 25, weight: .medium))
                
                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: "chevron.right")
                }
                .font(.body.bold())
                .rotationEffect(.degrees(isExpanded ? -90 : 90))
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isExpanded)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding([.top, .bottom], 20)
            
            if isExpanded {
                VStack {
                    Divider()
                        .background(Color.white)
                        .padding(.horizontal)
                    HStack {
                        Text(item.menuDescription)
                            .padding(.bottom, 10)
                            .padding(.top, 3)
                        
                        Spacer()
                    }
                    .padding()
                .transition(.opacity)
                }
                .foregroundColor(.white)
                
            }
        }
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(tapped ? 0.6 : 0.3), radius: tapped ? 20 : 10, x: 0, y: tapped ? 10 : 20)
        .scaleEffect(tapped ? 0.95 : 1)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isExpanded)
        .onTapGesture {
            tapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                tapped = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.navigateToPage.toggle()
            }
        }
    }
}

struct MenuItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage2(restaurant: .example)
    }
}
