//
//  NewTagView.swift
//  NewTagView
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI

struct NewTagView<T: Taggable>: View {
    @EnvironmentObject var user: User
    
    var item: T
    var type: NewTagViewType
    
    var body: some View {
        if type == .sheetView {
            NewTagViewSheet(item: item)
        } else if type == .pageView {
            NewTagViewPage(item: item)
        }
    }
    
    enum NewTagViewType {
        case sheetView, pageView
    }
}

struct NewTagView_Previews: PreviewProvider {
    static var previews: some View {
        NewTagView(item: MenuItem.example, type: .sheetView)
    }
}
