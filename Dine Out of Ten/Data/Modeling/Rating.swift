//
//  Rating.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/10/21.
//

import Foundation

struct Rating: CustomStringConvertible {
    var value: Float
    
    init(_ value: Float) {
        self.value = value.round(to: 1)
    }
    
    init(_ value: Int) {
        self.init(Float(value))
    }
    
    var description: String {
        String(format: "%.1f", value)
    }
}

extension Rating: Equatable, Comparable {
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func < (lhs: Rating, rhs: Rating) -> Bool {
        lhs.value < rhs.value
    }
}
