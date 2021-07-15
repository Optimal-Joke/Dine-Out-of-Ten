//
//  Taggable.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/9/21.
//

import SwiftUI
import OrderedCollections

protocol Taggable {
    var name: String { get set }
    var tags: OrderedSet<Tag> { get set }
}
