//
//  NewOrder.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation

extension MenuItem {
    func addOrder(withRating rating: Int) {
        self.addOrder(withRating: rating, atPrice: self.priceNow, withNotes: "")
    }

    func addOrder(withRating rating: Int, atPrice price: Double, withNotes notes: String) {
        let newOrder = Order(of: self, withRating: rating, atPrice: price, withNotes: notes)

        self.orders.append(newOrder)
    }
    
    func deleteOrder(_ order: Order) -> Order {
        self.orders.remove(at: self.orders.firstIndex { $0 == order }!)
    }
}

extension Restaurant {

    func orderItem(_ item: MenuItem, withRating rating: Int) {
        self.orderItem(item, withRating: rating, atPrice: item.priceNow, withNotes: "")
    }
    
    func orderItem(_ item: MenuItem, withRating rating: Int, atPrice price: Double, withNotes notes: String) {
        
        if let modifiedItem = menuItems.first(where: {$0 == item}) {  // item has been ordered before
            modifiedItem.addOrder(withRating: rating, atPrice: price, withNotes: notes)
        } else {  // new item
            item.addOrder(withRating: rating, atPrice: price, withNotes: notes)
            menuItems.append(item)
        }
    }
    
    /// Deletes the specified ``MenuItem`` from the restaurant entirely.
    /// - Parameter item: The `MenuItem` to be deleted.
    /// - Returns: The deleted `MenuItem`, returned as a convenience
    func deleteItem(_ item: MenuItem) -> MenuItem {
        self.menuItems.remove(at: self.menuItems.firstIndex { $0 == item }!)
    }
}
