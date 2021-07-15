//
//  DataEntryView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/25/21.
//

import Foundation

enum DataEntryView: Identifiable {
    var id: UUID {
        UUID()
    }
    
    case NewRestaurantView
    case NewItemView
    case NewOrderView
    case AddTagView
    case NewTagView
}
