//
//  MenuItemStatViewItem.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import SwiftUI

struct MenuItemStatViewItem: View {
    var type: MenuItemStatViewType
    var item: MenuItem
    
    let spacerHeight: CGFloat = 0
        
        var topText: Text? {
            let theText: String
            
            switch type {
            case .mostRecentPrice:
                theText = "Last Price"
            case .averageRating:
                theText = "Average Rating"
            case .itemRanking:
                theText = "Rank"
            case .dateOfLastRating:
                theText = "Last Rated"
            case .timesRated:
                theText = "Times Rated"
            }
            
            return Text(theText)
        }
    
        var mainText: Text {
            let theText: String
            
            switch type {
            case .mostRecentPrice(value: let value):
                theText = "$\(value.round(to: 2))"
            case .averageRating(value: let value):
                theText = value.description
            case .itemRanking(value: let value, outOf: _):
                var prettyRanking: Text {
                    Text("#").baselineOffset(6).font(.system(size: 24)) + Text("\(value)")
                    }
                return prettyRanking
            case .dateOfLastRating(value: let value):
                theText = value.format()
            case .timesRated(value: let value):
                theText = "\(value)"
            }
            
            return Text(theText)
        }
    
        var bottomText: Text? {
            let theText: String
            
            switch type {
            case .mostRecentPrice:
                return nil
            case .averageRating:
                theText = "out of 10"
            case .itemRanking(value: _, outOf: let numItems):
                theText = "out of \(numItems)"
            case .dateOfLastRating(value: let value):
                theText = value.describeElapsedInterval()
            case .timesRated:
                return nil
            }
            
            return Text(theText)
        }
        
        var topFont: Font {
            .subheadline.smallCaps()
        }
    
        var mainFont: Font {
            let font: Font
            
            switch type {
            case .mostRecentPrice:
                font = .custom("SF Rounded", size: 35, relativeTo: .largeTitle)
            case .averageRating:
                font = .largeTitle
            case .itemRanking:
                font = .largeTitle
            case .dateOfLastRating:
                font = .title
            case .timesRated:
                font = .custom("SF Rounded", size: 45, relativeTo: .largeTitle)
            }
            
            return font
        }
    
        var bottomFont: Font {
            .subheadline
        }
    
    var body: some View {
        VStack {
            topText
                .font(topFont)
                .foregroundColor(.secondary)
            Spacer(minLength: spacerHeight)
            mainText
                .font(mainFont)
                .foregroundColor(.secondary)
            Spacer(minLength: spacerHeight)
            bottomText
                .font(bottomFont)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 15)
    }
}

extension MenuItemStatViewItem {
    enum MenuItemStatViewType {
        case mostRecentPrice(value: Double)
        case averageRating(value: Rating)
        case itemRanking(value: Int, outOf: Int)
        case dateOfLastRating(value: Date)
        case timesRated(value: Int)
    }
}

struct MenuItemStatViewItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemStatView(item: MenuItem.example)
    }
}
