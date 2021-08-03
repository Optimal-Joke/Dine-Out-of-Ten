//
//  HelperFunctions.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import Foundation
import SwiftUI

// MARK: Rounding Floating Point
extension BinaryFloatingPoint {
    func round(to places: Int) -> Self {
        let divisor = Self(pow(10.0, Double(places)))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: Describe Elapsed Interval Since Date
extension Date {
    func describeElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return (year == 1) ? "\(year) year ago" : "\(year) years ago"
        } else if let month = interval.month, month > 0 {
            return (month == 1) ? "\(month) month ago" : "\(month) months ago"
        } else if let week = interval.weekOfYear, week > 0 {
            return (week == 1) ? "last week" : "\(week) weeks ago"
        } else if let day = interval.day, day > 0 {
            return (day == 1) ? "yesterday" : "\(day) days ago"
        } else {
            return "today"
        }
    }
    
    func format(dateStyle: DateFormatter.Style = .long) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = .none

        // Convert Date to String
        let formatted = dateFormatter.string(from: self)
        
        return formatted
    }
}

// MARK: Average of Array of Ratings
extension Array where Element == Rating {
    var average: Rating {
        let avg = self.reduce(0.0) {
            $0 + $1.value / Float(self.count)
        }
        return Rating(avg)
    }
}

// MARK: Custom Form View
struct CustomFormEntry<Content: View>: View {
    var header: String
    var modifiersEnabled: Bool
    var content: Content
    
    @Environment(\.colorScheme) var colorScheme

    init(_ header: String = "", modifiersEnabled: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.modifiersEnabled = modifiersEnabled
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if header != "" {
                Text(header)
                    .font(.headline)
            }
            
            if modifiersEnabled {
                content
                    .padding(.all)
                    .background(colorScheme == .light
                                ? Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
                                : Color(red: 16.0/255.0, green: 12.0/255.0, blue: 11.0/255.0, opacity: 1.0))
                    .cornerRadius(10)
            } else {
                content
                    .padding(.all)
            }
        }
    }
}


// MARK: Random Color
extension Color {
    static func random() -> Color {
        return Color(
            red:     .random(in: 0.15..<1),
            green:   .random(in: 0.15..<1),
            blue:    .random(in: 0.15..<1),
            opacity: 1.0
        )
    }
}

// MARK: - Conditional View Modifier
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - iOS Availibility Bool Ext.
extension Bool {
    static var iOS13: Bool {
        if #available(iOS 13, *) { return true } else { return false }
    }
    
    static var iOS14: Bool {
        if #available(iOS 14, *) { return true } else { return false }
    }
    
    static var iOS15: Bool {
        if #available(iOS 15, *) { return true } else { return false }
    }
}

