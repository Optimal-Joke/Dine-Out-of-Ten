//
//  NewOrder.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation

extension MenuItem {
    func order(withRating rating: Int) {
        self.order(withRating: rating, atPrice: self.priceNow, withNotes: "")
    }

    func order(withRating rating: Int, atPrice price: Double, withNotes notes: String) {
        let newOrder = Order(of: self, withRating: rating, atPrice: price, withNotes: notes)

        self.orders.append(newOrder)
    }
    
    func deleteOrder() {
        
    }
}

extension Restaurant {

    func addNewOrder(of item: MenuItem, withRating rating: Int) {
        self.addNewOrder(of: item, withRating: rating, atPrice: item.priceNow, withNotes: "")
    }
    
    func addNewOrder(of item: MenuItem, withRating rating: Int, atPrice price: Double, withNotes notes: String) {
        
        if let modifiedItem = menuItems.first(where: {$0 == item}) {  // item has been ordered before
            modifiedItem.order(withRating: rating, atPrice: price, withNotes: notes)
        } else {  // new item
            item.order(withRating: rating, atPrice: price, withNotes: notes)
            menuItems.append(item)
        }
    }
    
    func delete(order: Order) {
        // if only one order of item remaining, delete menuItem from restaurant (PROBABLY SHOULDN'T, maybe give user option?)
        // else delete order?
    }
}
