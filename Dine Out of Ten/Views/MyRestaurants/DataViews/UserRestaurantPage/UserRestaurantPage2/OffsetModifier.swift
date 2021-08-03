//
//  OffsetModifier.swift
//  OffsetModifier
//
//  Created by Hunter Holland on 7/31/21.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { g -> Color in
                    
                    // getting minY value for coordinate space named SCROLL
                    let minY = g.frame(in: .named("SCROLL")).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return Color.clear
                }, alignment: .top
            )
    }
}

extension View {
    func offset(_ offset: Binding<CGFloat>) -> some View {
        self.modifier(OffsetModifier(offset: offset))
    }
}
