//
//  CustomStringConvertible.swift
//  CustomStringConvertible
//
//  Created by Hunter Holland on 7/21/21.
//

import Foundation

// MARK: Restaurant
extension Restaurant: CustomStringConvertible {
    var description: String {
        "\(name)"
    }
}

// MARK: MenuItem
extension MenuItem: CustomStringConvertible {
    var description: String {
        "\(name), \(averageRating)"
    }
}

// MARK: Order
extension Order: CustomStringConvertible {
    var description: String {
        "\(itemName), \(dateConsumed.format(dateStyle: .medium)), \(rating)"
    }
}

// MARK: Rating
extension Rating: CustomStringConvertible {
    var description: String {
        String(format: "%.1f", value)
    }
}
