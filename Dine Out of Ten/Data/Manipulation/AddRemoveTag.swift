//
//  AddRemoveTag.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import Foundation
import SwiftUI

// MARK: User
extension User {
    // MARK: Add Tag
    func addTag(_ tag: Tag, to item: Taggable) throws {
        switch item {
        case let menuItem as MenuItem:
            try self.addTag(tag, to: menuItem)
        case let restaurant as Restaurant:
            try self.addTag(tag, to: restaurant)
        default:
            debugPrint("Input parameter `to` of addTag conforms to Taggable but is not accounted for in body of function.")
        }
    }
    
    private func addTag(_ tag: Tag, to menuItem: MenuItem) throws {
        // make sure tag is unique
        guard !self.menuItemTags.contains(tag) && !menuItem.hasTag(tag) else {
            throw TagCreationError.TagNotUnique
        }
        
        self.menuItemTags.append(tag)
        menuItem.addTag(tag)
    }
    
    private func addTag(_ tag: Tag, to restaurant: Restaurant) throws {
        // make sure tag is unique
        guard !self.restaurantTags.contains(tag) && !restaurant.hasTag(tag) else {
            throw TagCreationError.TagNotUnique
        }
        
        self.restaurantTags.append(tag)
        restaurant.addTag(tag)
    }
    
    // MARK: Remove Tag
    func removeTag(_ tag: Tag, from item: Taggable, permanently: Bool = false) {
        item.removeTag(tag)
        
        if permanently {
            switch item {
            case let menuItem as MenuItem:
                self.deleteTag(tag, from: menuItem)
            case let restaurant as Restaurant:
                self.deleteTag(tag, from: restaurant)
            default:
                debugPrint("Input parameter `from` to removeTag conforms to Taggable but is not accounted for in body of function.")
                return
            }
        }
    }
    
    private func deleteTag(_ tag: Tag, from menuItem: MenuItem) {
        self.menuItemTags.remove(tag)
    }
    
    private func deleteTag(_ tag: Tag, from restaurant: Restaurant) {
        self.restaurantTags.remove(tag)
    }
}
