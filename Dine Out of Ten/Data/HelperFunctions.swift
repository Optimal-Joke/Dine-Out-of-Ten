//
//  HelperFunctions.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 12/29/20.
//

import Foundation
import SwiftUI

// MARK: Rounding Floating Point
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: Describe Elapsed Interval Since Date
extension Date {
    func describeElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute], from: self, to: Date())
        
        let description: String

        if let year = interval.year, year > 0 {
            description = (year == 1) ? "\(year) year ago" : "\(year) years ago"
        } else if let month = interval.month, month > 0 {
            description = (month == 1) ? "\(month) month ago" : "\(month) months ago"
        } else if let week = interval.weekOfYear, week > 0 {
            description = (week == 1) ? "last week" : "\(week) weeks ago"
        } else if let day = interval.day, day > 0 {
            description = (day == 1) ? "yesterday" : "\(day) days ago"
        } else {
            description = "today"
        }
        return description
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

// MARK: Average Rating of Array of Ratings
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
