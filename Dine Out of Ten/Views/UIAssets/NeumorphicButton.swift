//
//  NeumorphicButton.swift
//  NeumorphicButton
//
//  Created by Hunter Holland on 8/21/21.
//

import SwiftUI

struct NeumorphicButton: View {
    var text: String
    
    @State private var tapped = false
    
    var body: some View {
//        GeometryReader { geo in
            Text(text)
                .font(.system(size: 20, weight: .semibold, design: .default))
//                .frame(width: geo.size.width / 2.5, height: buttonHeight)
                .frame(width: 140, height: buttonHeight)
                .padding(.horizontal)
                .background(
                    ZStack {
                        offWhiteColor
                        
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .foregroundColor(offWhiteColor)
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .shadow(color: shadowColor, radius: shadowRadius, x: 10, y: 10)
                .shadow(color: offWhiteColor, radius: shadowRadius, x: -10, y: -10)
                .scaleEffect(tapped ? 0.95 : 1.0)
                .onTapGesture {
                    self.tapped = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self.tapped = false
                    }
            }
//        }
    }
    
    // MARK: Sizes
    private let buttonWidth: CGFloat = 140
    private let buttonHeight: CGFloat = 40
    private let cornerRadius: CGFloat = 16
    
    private var shadowRadius: CGFloat {
        tapped ? 10 : 15
    }
    
    // MARK: Colors
    private let offWhiteColor: Color = Color.black.opacity(0.07)
    
    private var shadowColor: Color {
        let opacity = tapped ? 0.07 : 0.3
        
        return Color.black.opacity(opacity)
    }
    
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicButton(text: "Button Text")
//            .foregroundColor(.accentColor)
    }
}
