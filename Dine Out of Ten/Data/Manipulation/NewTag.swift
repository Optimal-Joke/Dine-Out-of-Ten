//
//  NewTag.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import Foundation
import SwiftUI

extension User {
    
    @discardableResult func addTag(label: String, colors: [Color], to item: Taggable) -> Bool {
        let newTag = Tag(label: label, colors: colors)
        return self.addTag(newTag, to: item)
    }
    
    @discardableResult func addTag(_ tag: Tag, to item: Taggable) -> Bool {
        switch item {
        case let menuItem as MenuItem:
            return self.addTag(tag, to: menuItem)
        case let restaurant as Restaurant:
            return self.addTag(tag, to: restaurant)
        default:
            debugPrint("Input parameter `to` to addTag conforms to Taggable but is not accounted for in body of function.")
            return false
        }
    }
    
    private func addTag(_ tag: Tag, to menuItem: MenuItem) -> Bool {
        guard !self.menuItemTags.contains(tag) else {
            return false
        }
        
        let result1 = self.menuItemTags.append(tag)
        let result2 = menuItem.tags.append(tag)
        
        return result1.inserted && result2.inserted
    }
    
    private func addTag(_ tag: Tag, to restaurant: Restaurant) -> Bool {
        guard !self.restaurantTags.contains(tag) else {
            return false
        }
        
        let result1 = self.restaurantTags.append(tag)
        let result2 = restaurant.tags.append(tag)
        
        return result1.inserted && result2.inserted
    }
    
    func removeTag(_ tag: Tag, from item: Taggable, permanently: Bool = false) {
        switch item {
        case let menuItem as MenuItem:
            self.removeTag(tag, from: menuItem, permanently: permanently)
        case let restaurant as Restaurant:
            self.removeTag(tag, from: restaurant, permanently: permanently)
        default:
            debugPrint("Input parameter `from` to removeTag conforms to Taggable but is not accounted for in body of function.")
            return
        }
    }
    
    private func removeTag(_ tag: Tag, from menuItem: MenuItem, permanently: Bool = false) {
        menuItem.tags.removeAll { $0 == tag }
        
        if permanently { self.menuItemTags.remove(tag) }
    }
    
    private func removeTag(_ tag: Tag, from restaurant: Restaurant, permanently: Bool = false) {
        restaurant.tags.removeAll { $0 == tag }
        
        if permanently { self.restaurantTags.remove(tag) }
    }
}
