//
//  ThingsToKnowView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/3/21.
//

import SwiftUI

struct TipsView: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tips")
                .font(.title3.weight(.medium))
            
            TextField("Ex: Ask for extra sauce", text: $text)
        }
    }
}

#if DEBUG
struct ThingsToKnowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemPage(item: MenuItem.example)
    }
}
#endif
