//
//  FilteredList.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/9/21.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    let content: (T) -> Content
    
    var filteredItems: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        List(filteredItems, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(sortDescriptors descriptors: [NSSortDescriptor], filterKey: String, filterValue: String, predicate: SortPredicate, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: descriptors, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
    }
    
//    init(sortDirection: SortDirection, filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
//        self.sortDirection = sortDirection
//        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
//        self.content = content
//    }
    
    var fetchRequest: FetchRequest<T>
}

enum SortPredicate: String {
    case beginsWith = "BEGINSWITH"
    case contains   = "CONTAINS"
    case endsWith   = "ENDSWITH"
}

enum SortDirection {
    case ascending, descending
}

enum SortParameter {
    case name
    case rating
    case distance
    case cuisine
    case timesOrdered
    case tagsContained
}
