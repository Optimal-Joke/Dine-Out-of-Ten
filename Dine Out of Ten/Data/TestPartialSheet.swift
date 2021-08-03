//
//  TestPartialSheet.swift
//  TestPartialSheet
//
//  Created by Hunter Holland on 7/19/21.
//

import SwiftUI
import PartialSheet

struct TestPartialSheet: View {
    
    @EnvironmentObject var partialSheet : PartialSheetManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                Button(action: {
                    self.partialSheet.showPartialSheet({
                        print("dismissed")
                    }) {
                        Text("Partial Sheet")
                    }
                }, label: {
                    Text("Show Partial Sheet")
                })
                Spacer()
            }
            .navigationBarTitle("Partial Sheet")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .addPartialSheet()
    }
}


struct TestPartialSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestPartialSheet()
    }
}
