//
//  NeumorphicCard.swift
//  NeumorphicCard
//
//  Created by Hunter Holland on 8/23/21.
//

import SwiftUI

struct NeumorphicCard: View {
    var body: some View {
        ZStack {
            Color.offWhite
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.offWhite)
                .frame(width: 150, height: 150)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct NeumorphicCard_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicCard()
    }
}
