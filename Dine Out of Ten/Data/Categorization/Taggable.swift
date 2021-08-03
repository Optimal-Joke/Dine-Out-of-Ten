//
//  Taggable.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/9/21.
//

import SwiftUI
import OrderedCollections

protocol Taggable: AnyObject {
    var tags: OrderedSet<Tag> { get set }
    
    func hasTag(_ tag: Tag) -> Bool
    func addTag(_ tag: Tag)
    func removeTag(_ tag: Tag)
}

extension Taggable {
    func hasTag(_ tag: Tag) -> Bool {
        self.tags.contains(tag)
    }
    
    func addTag(_ tag: Tag) {
        self.tags.append(tag)
    }
    
    func removeTag(_ tag: Tag) {
        self.tags.remove(tag)
    }
}
