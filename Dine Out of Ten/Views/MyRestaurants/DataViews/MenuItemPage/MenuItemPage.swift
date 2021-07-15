//
//  MenuItemPage.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import SwiftUI

struct MenuItemPage: View {
    @ObservedObject var item: MenuItem
    
    @EnvironmentObject var user: User
    
//    @State var editMode: EditMode = .inactive
    @State private var selection: Set<Order> = []
    @State private var tagsAreEditable = false
    
    @State private var sheetSelection: DataEntryView? = nil
    @State private var addTagViewShowing: Bool = false
        
    var body: some View {
        ZStack {
            ScrollView {
                ItemTagListView(for: item, deleteable: tagsAreEditable, trailingButtonMode: .dynamic(primaryLabel: "Edit Tags...", secondaryLabel: "Add Tags...")) {
                    addTagViewShowing = true
                }
                    .padding(.horizontal, 15)
                
                MenuItemStatView(item: item)
                
                TipsView(text: $item.tips)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                VStack(alignment: .leading) {
                    Text("Orders")
                        .font(.title2.weight(.semibold))
                    
                    ForEach(item.orders) { order in
                        OrderRow(order: order, isExpanded: self.selection.contains(order))
                            .onTapGesture {
                                tap(order: order)
                            }
                            .modifier(ListRowModifier())
                            .animation(
                                Animation.linear(duration: 0.15)
                            )
                    }
                    .onDelete(perform: removeOrders)
                }
                .padding(.horizontal)
            }
            .animation(.easeInOut(duration: 0.15))
            .navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.large)
    //        .environment(\.editMode, self.$editMode)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
    //                EditButton()
                    
                    Button(action: {
                        tagsAreEditable.toggle()
                    }, label: {
                        Text("Edit")
                            .foregroundColor(.accentColor)
                    })
                    
                    Button(action: {
                        sheetSelection = .NewOrderView
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    })
                }
            }
            .sheet(item: $sheetSelection) { selectedTarget in
                switch selectedTarget {
                case .NewOrderView:
                    NewOrderView(item: item)
                case .NewTagView:
                    NewTagView(item: item)
                default:
                    EmptyView()
                }
            }
            
            if addTagViewShowing { AddTagView(item: item) }
        }
    }
    
    private func tap(order: Order) {
        if selection.contains(order) {
            selection.remove(order)
//            print("The following order's information was retracted:")
//            print("    \(order.description)")
        } else {
            selection.insert(order)
//            print("The following order's information was expanded:")
//            print("    \(order.description)")
        }
    }
    
//    private var editButton: some View {
//       Button(action: {
//           self.editMode.toggle()
//       }) {
//           Text(self.editMode.title)
//       }
//   }
    
    private func removeOrders(at offsets: IndexSet) {
        item.orders.remove(atOffsets: offsets)
    }
}


extension EditMode {
    var title: String {
        self == .active ? "Done" : "Edit"
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider().offset(y: -2)
        }
    }
}

struct MenuItemPage_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemPage(item: MenuItem.example)
    }
}
