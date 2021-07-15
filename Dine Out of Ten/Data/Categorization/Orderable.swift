//
//  Orderable.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation

protocol Orderable {
    var name: String { get }
    var type: MenuItemType { get }
    var priceNow: Double { get }
    var menuDescription: String { get set }
    var restaurant: Restaurant { get }
    var lastConsumed: Date { get }
    
    var orders: [Order] { get set }
    var tags: [Tag] { get set }
    
    var numOrders: Int { get }
    var averageRating: Rating { get }
    
    func order(withRating rating: Int)
    func order(withRating rating: Int, atPrice price: Double, withNotes notes: String) 
}
