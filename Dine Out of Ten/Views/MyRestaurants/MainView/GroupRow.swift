//
//  GroupRow.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import SwiftUI

struct GroupRow: View {
    let label: String
    let icon: String
    
    var body: some View {
        Label {
            Text(label)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow(label: "Test Label", icon: "plus")
    }
}
