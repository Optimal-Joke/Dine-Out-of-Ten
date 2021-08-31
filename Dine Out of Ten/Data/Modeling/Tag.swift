//
//  Tag.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import Foundation
import SwiftUI

// MARK: Tag Model
struct Tag: Identifiable {
    var id = UUID()
    var label: String
    var colors: [Color]
    
    var color: LinearGradient {
        LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
    
    init(label: String, colors: [Color]) {
        self.label = (label == "") ? "🧐 Preview" : label
        self.colors = colors
    }
    
    static var example: Tag {
        Tag(label: "Example Tag", colors: [.red, .green, .blue])
    }
}

extension Tag: Equatable, Hashable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.label == rhs.label
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Tag: Codable { }
