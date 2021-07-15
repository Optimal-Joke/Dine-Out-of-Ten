//
//  NewMenuItemView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 1/1/21.
//

import SwiftUI
import OrderedCollections

struct NewMenuItemView: View {
//    @State private var newItem: MenuItem
    
    @State private var restaurantName = ""
    
    @State private var itemName = ""
    @State private var itemPrice = ""
    @State private var itemTags = OrderedSet<Tag>()
    @State private var itemDescription = "Description on menu..."
    
    @State private var dateOrdered = Date()
    @State private var itemRating: Int = 9
    @State private var orderComments = "Comments"
    
    @State private var showExtraInfo: Bool = false
    
    private let possibleRatings = Array(0...10)
    
    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertShowing = false
    
    init() {
        
    }
    
    /// This doesn't work. TODO: Make this work
    init(for restaurant: Restaurant) {
        self.restaurantName = restaurant.name
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $itemName)
                
                TextField("Restaurant Name", text: $restaurantName)
                
                // item type
//                HStack {
//                    Picker(selection: $itemType, label: Text("Type: ")) {
//                        ForEach(MenuItemType.allCases, id: \.self) {
//                            Text($0.rawValue)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .frame(maxHeight: 100)
//                    Text("\(itemType.rawValue)")
//                }
                
//                TextField("Price", text: $itemPrice)
//
//                TextEditor(text: $itemDescription)
//                    .foregroundColor(self.itemDescription == "Description on menu..." ? .gray : .primary)
//                    .opacity(0.55)
//                    .onTapGesture {
//                        if self.itemDescription == "Description on menu..." {
//                            self.itemDescription = ""
//                        }
//                    }
                
//                Section(header: Text("Tags")) {
//                    if user.menuItemTags.count > 0 {
//                            TagListView<MenuItem>(with: itemTags, deletable: true, size: .small)
//                                .buttonStyle(BorderlessButtonStyle())
//
//                            TagListView<MenuItem>(with: user.menuItemTags, deletable: false, size: .small)
//                                .buttonStyle(BorderlessButtonStyle())
//                    } else {
//                        TagListView<MenuItem>(with: itemTags, deletable: true, size: .small)
//                            .buttonStyle(BorderlessButtonStyle())
//                    }
//                }
                
                Section(header: Text("Order Rating and Information"),
                        footer: Text("Was this item what you expected? Did you enjoy it? Was it better than the last time you ordered it?")) {
                    Picker(selection: $itemRating, label: Text("Order Rating")) {
                        ForEach(0..<self.possibleRatings.count) {
                            Text(String(self.possibleRatings[$0]))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    DatePicker("Date Ordered", selection: $dateOrdered, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                    TextEditor(text: $orderComments)
                        .foregroundColor(self.orderComments == "Comments" ? .gray : .primary)
                        .opacity(0.55)
                        .onTapGesture {
                            if self.orderComments == "Comments" {
                                self.orderComments = ""
                            }
                        }
                }
            }
            .navigationTitle(Text("New Item"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Add+") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Button("Save") {
                        if let restaurant = findRestaurant(withName: restaurantName) {
                            if let item = findItem(withName: itemName, at: restaurant) {
                                if let actualPrice = Double(itemPrice) {
                                    item.order(withRating: itemRating, atPrice: actualPrice, withNotes: orderComments)
                                }
                            } else {
                                let newItem = MenuItem(name: itemName, description: itemDescription, restaurant: restaurant)
                                if let actualPrice = Double(itemPrice) {
                                    newItem.order(withRating: itemRating, atPrice: actualPrice, withNotes: orderComments)
                                }
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            userInputAlert(title: "Invalid Restaurant Name", message: "Please enter the exact name of a restaurant you've ordered from before")
                        }
                        
                        
                    }
                }
            }
            .alert(isPresented: $isAlertShowing) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("Back")))
            }
        }
    }
    
    func findRestaurant(withName name: String) -> Restaurant? {
        user.restaurants.first { $0.name == name }
    }
    
    func findItem(withName name: String, at restaurant: Restaurant) -> MenuItem? {
        restaurant.menuItems.first { $0.name == name }
    }
    
    func userInputAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isAlertShowing = true
    }
}

struct AddMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        NewMenuItemView(for: .example)
    }
}
