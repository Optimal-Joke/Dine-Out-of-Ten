//
//  UserRestaurantPage2.swift
//  UserRestaurantPage2
//
//  Created by Hunter Holland on 7/26/21.
//

import SwiftUI

struct UserRestaurantPage2: View {
    var restaurant: Restaurant

    var body: some View {
        GeometryReader { g in
            let topEdgeOfPage = g.safeAreaInsets.top

            UserRestaurantPage3(restaurant: restaurant, topEdge: topEdgeOfPage)
                .ignoresSafeArea(.all, edges: .top)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct UserRestaurantPage3: View {
    var restaurant: Restaurant
    var topEdge: CGFloat

    var headerMaxHeight: CGFloat {
        UIScreen.main.bounds.height / 2 + topEdge / 2
    }

    @State private var offsetAmount: CGFloat = 0

//    @State private var sheetSelection: DataEntryView? = nil
    @State private var showNewMenuItemView = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {

                VStack(spacing: 15) {

                    GeometryReader { g in

                        TopBar(restaurant: restaurant, topEdge: topEdge, offset: $offsetAmount, maxHeight: headerMaxHeight)
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
    //                                        Label("Back", systemImage: "chevron.left")
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

                    VStack(spacing: 10) {
                        ForEach(restaurant.menuItems) { menuItem in
                            MenuItemCardView(item: menuItem)
                        }
                    }
                    .padding(.horizontal)
                    .zIndex(0)
//                    .sheet(isPresented: $showNewMenuItemView) {
//                        NewMenuItemView(for: restaurant)
//                    }
                    
    //                .sheet(item: $sheetSelection) { selectedTarget in
    //                    switch selectedTarget {
    //                    case .NewItemView:
    //                        NewMenuItemView(for: restaurant)
    //                    default:
    //                        EmptyView()
    //                    }
    //                }
                }
                .offset($offsetAmount)
                
            }
            .coordinateSpace(name: "SCROLL")
        }
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
}


struct UserRestaurantPage2_Previews: PreviewProvider {
    static var previews: some View {
        UserRestaurantPage2(restaurant: .example)
    }
}
