//
//  Codable.swift
//  Codable
//
//  Created by Hunter Holland on 7/21/21.
//

import SwiftUI
import OrderedCollections
import MapKit

// MARK: Restaurant
extension Restaurant: Codable {
    enum CodingKeys: CodingKey {
        case id, name, tags, menuItems, location
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(tags, forKey: .tags)
        try container.encode(menuItems, forKey: .menuItems)
        try container.encode(location, forKey: .location)
//        try container.encode(address, forKey: .address)
//        try container.encode(placemark, forKey: .placemark)
    }
}


// MARK: - MenuItem
extension MenuItem: Codable {
    enum CodingKeys: CodingKey {
        case id, restaurantID, name, menuDescription, wouldOrderAgain, tips, tags, orders
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(restaurantID, forKey: .restaurantID)
        try container.encode(name, forKey: .name)
        try container.encode(menuDescription, forKey: .menuDescription)
        try container.encode(wouldOrderAgain, forKey: .wouldOrderAgain)
        try container.encode(tips, forKey: .tips)
        try container.encode(tags, forKey: .tags)
        try container.encode(orders, forKey: .orders)
    }
}

// MARK: - Location
extension Location: Codable {
    enum CodingKeys: CodingKey {
        case address, placemark
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(address, forKey: .address)
        try container.encode(placemark, forKey: .placemark)
    }
}

// MARK: - Color
extension Color: Codable {
    private struct Components {
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
    }
    
    private enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }
    
    private var components: Components {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Components(red: Double(red),
                          green: Double(green),
                          blue: Double(blue),
                          alpha: Double(alpha))
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        let alpha = try container.decode(Double.self, forKey: .alpha)
        self.init(Components(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    private init(_ components: Components) {
        self.init(.sRGB, red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let components = self.components
        try container.encode(components.red, forKey: .red)
        try container.encode(components.green, forKey: .green)
        try container.encode(components.blue, forKey: .blue)
        try container.encode(components.alpha, forKey: .alpha)
    }
    
    // MARK: font colors
    /// This color is either black or white, whichever is more accessible.
    var accessibleFontColor: Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil)
        return isLightColor(red: red, green: green, blue: blue) ? .black : .white
    }
    
    private func isLightColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> Bool {
        let lightRed = red > 0.65
        let lightGreen = green > 0.65
        let lightBlue = blue > 0.65
        
        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }
}

