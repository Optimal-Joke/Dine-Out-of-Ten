//
//  UserRestaurantPage2.swift
//  UserRestaurantPage2
//
//  Created by Hunter Holland on 7/26/21.
//

import SwiftUI

struct UserRestaurantPage2: View {
    @StateObject var restaurant: Restaurant

    var body: some View {
        GeometryReader { g in
            let topEdgeOfPage = g.safeAreaInsets.top

            UserRestaurantPage3(topEdge: topEdgeOfPage)
                .ignoresSafeArea(.all, edges: .top)
                .navigationBarTitle(restaurant.name)
                .navigationBarHidden(true)
        }
        .environmentObject(restaurant)
    }
}

struct UserRestaurantPage3: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var restaurant: Restaurant
    @EnvironmentObject var user: User
    var topEdge: CGFloat

    var headerMaxHeight: CGFloat {
        UIScreen.main.bounds.height / 3 + topEdge / 2
    }

    @State private var offsetAmount: CGFloat = 0

//    @State private var sheetSelection: DataEntryView? = nil
    @State private var showNewMenuItemView = false
    
//    @State private var showEditTagsView = falsex

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    /// Page header
                    GeometryReader { g in
                        TopBar(topEdge: topEdge, offset: $offsetAmount, maxHeight: headerMaxHeight)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            // sticky effect
                            .frame(height: getHeaderHeight(), alignment: .bottom)
                            .background(Color.accentColor,
                                        in: CustomCorner(corners: [.bottomLeft, .bottomRight], radius: getCornerRadius()))
                            .overlay(
                                // top navigation view
                                HStack(spacing: 15) {

                                    Button {
                                        self.presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(systemName: "arrow.backward")
                                    }
                                    .font(.body.weight(.medium))

                                    Group {
                                        Text(restaurant.name)
                                    }
                                    .font(.body.bold())
                                    .opacity(getTopBarTitleOpacity())

                                    Spacer()

                                    Button {

                                    } label: {
                                        Image(systemName: "line.3.horizontal.decrease")
                                    }
                                    .font(.body.bold())

                                    Button {
                                        self.showNewMenuItemView = true
    //                                    self.sheetSelection = .NewItemView
                                    } label: {
                                        Image(systemName: "plus")
                                    }
                                    .font(.body.bold())

                                }
                                    .padding()
                                    // maxheight
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .padding(.top, topEdge)
                                , alignment: .top
                            )
                        
                    }
                    .frame(height: headerMaxHeight)
                    // fixing background at top of screen
                    .offset(y: -offsetAmount)
                    .zIndex(1)

                    /// Menu items
                    VStack(spacing: 10) {
                        ForEach(restaurant.menuItems) { menuItem in
                            MenuItemCardView(item: menuItem)
                        }
                    }
                    .padding(.horizontal)
                    .zIndex(0)
                    .sheet(isPresented: $showNewMenuItemView) {
                        NewMenuItemView(for: restaurant)
                    }
                }
                .offset($offsetAmount)
                
            }
            .coordinateSpace(name: "SCROLL")
        }
    }
    
//    private func getHeaderMaxHeight(in proxy: GeometryProxy) -> CGFloat {
//        
//    }
    
    // calculating opacity
    private func getOpacity() -> CGFloat {
        let progress = -(90 + offsetAmount + topEdge) / 40
        
        let opacity = 1 - progress
        
        return -offsetAmount > (90 + topEdge) ? opacity : 1
    }

    private func getHeaderHeight() -> CGFloat {
        let topHeight = headerMaxHeight + offsetAmount

        // 70 is going to be our constant navigation bar height
        return topHeight > (70 + topEdge) ? topHeight : (70 + topEdge)
    }

    private func getCornerRadius() -> CGFloat {
        let progress = -offsetAmount / (headerMaxHeight - (80 + topEdge))

        let value = 1 - progress

        let radius = value * 30

        return offsetAmount < 0 ? radius : 30
    }

    private func getTopBarTitleOpacity() -> CGFloat {
        let opacity = -(140 + offsetAmount + topEdge) / 80

        return -offsetAmount > (140 + topEdge) ? opacity : 0
    }
    
    private var backgroundColor: Color {
        colorScheme == .light ? BackgroundColor.light.start : BackgroundColor.dark.start
    }
}

struct UserRestaurantPage2_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage2(restaurant: .example)
    }
}
