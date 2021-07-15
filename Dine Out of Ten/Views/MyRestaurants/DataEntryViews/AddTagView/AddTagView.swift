//
//  AddTagView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/13/21.
//

import SwiftUI
import OrderedCollections

struct AddTagView<T>: View where T: ObservableObject, T: Taggable {
    @EnvironmentObject var user: User
    
    @ObservedObject var item: T
    
    @State private var bottomSheetShown = false
    @State private var newTagViewShowing: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            BottomSheetView(isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.7
            ) {
                Group {
                    if item.tags.count > 0 {
                        ItemTagListView(for: item, size: .small,
                                           deleteable: true, trailingButtonMode: .stable(label: "")) {
                            
                        }
                       .buttonStyle(BorderlessButtonStyle())
                       .padding(.horizontal)
                    } else {
                        TagView(for: Tag(label: "No Tags Yet 🤨", colors: [.red]), item: MenuItem.example, size: .small)
                    }
                    
                    
                    Divider()
                        .frame(height: 40)
                        .animation(.easeInOut(duration: 0.25))
                    
                    UserTagListView(for: item, editing: true) {
                        newTagViewShowing = true
                    }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $newTagViewShowing) {
            NewTagView(item: item)
        }
    }
    
    var userTagsNotSelected: OrderedSet<Tag> {
        switch item {
        case let restaurant as Restaurant:
            return user.restaurantTags.subtracting(restaurant.tags)
        case let menuItem as MenuItem:
            return user.menuItemTags.subtracting(menuItem.tags)
        default:
            debugPrint("FILL THIS OUT")
            return []
        }
    }
}

struct AddTagView_Previews: PreviewProvider {
    static let item = MenuItem.example
    
    static var previews: some View {
        ZStack {
            MenuItemPage(item: item)
            
            AddTagView(item: item).environmentObject(User(generateTestData: true, ordersPerItem: 10))
        }
    }
}
