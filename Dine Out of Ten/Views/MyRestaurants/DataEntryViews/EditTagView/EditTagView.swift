//
//  EditTagView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/13/21.
//

import SwiftUI
import OrderedCollections

struct EditTagView<T>: View where T: ObservableObject, T: Taggable {
    @EnvironmentObject var user: User
    @ObservedObject var item: T
    
    @State private var newTagViewShowing: Bool = false
    
    var body: some View {
        VStack {
            if item.tags.count > 0 {
                ItemTagListView(for: item, size: .small,
                                   deletable: true, trailingButtonMode: .stable(label: "")) {
                    
                }
                                   .buttonStyle(BorderlessButtonStyle())
                                   .padding(.horizontal)
            } else {
                StaticTagView(for: Tag(label: "No Tags Yet 🤨", colors: [.red]), item: MenuItem.example)
            }
            
            Divider()
//                .frame(height: 40)
            
            UserTagListView(for: item, editing: true) {
                newTagViewShowing = true
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical, 20)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $newTagViewShowing) {
            NewTagView(item: item, type: .sheetView)
        }
    }
}

struct AddTagView_Previews: PreviewProvider {
    static let item = MenuItem.example
    
    static var previews: some View {
        EditTagView(item: item).environmentObject(User(testOrdersPerItem: 10))
    }
}
