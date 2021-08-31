//
//  Rating.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/10/21.
//

import Foundation

struct Rating {
    var value: Float
    
    init(_ value: Float) {
        self.value = value.round(to: 1)
    }
    
    init(_ value: Int) {
        self.init(Float(value))
    }
    
    static var example: Rating {
        Rating(9)
    }
}

extension Rating: Equatable, Comparable {
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        lhs.value == rhs.value
    }
    
    static func < (lhs: Rating, rhs: Rating) -> Bool {
        lhs.value < rhs.value
    }
}

extension Rating: Codable { }
