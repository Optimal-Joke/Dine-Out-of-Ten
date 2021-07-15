//
//  ProgressRing.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/10/21.
//

import SwiftUI

struct CharacterProgressRing: View {
    @Binding var text: String
    var maxCharacters: Int
    
    init(forText text: Binding<String>, maxCharacters: Int = 20) {
        self._text = text
        self.maxCharacters = maxCharacters
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.accentColor.opacity(0.15), style: StrokeStyle(lineWidth: lineWidth))
            
            Circle()
                .trim(from: 0.0, to: self.progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(circleColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            if size == .normal {
                Text("\(charactersRemaining)")
                    .font(textFont)
                    .foregroundColor(textColor)
            }
        }
        .frame(width: radius)
        .animation(.linear(duration: 0.15))
    }
    
    var progress: Double {
        Double(text.count) / Double(maxCharacters)
    }
    
    var charactersRemaining: Int {
        maxCharacters - text.count
    }
    
    var size: CharacterProgressRing.Size {
        switch charactersRemaining {
        case 6...:
            return .minimal
        default:
            return .normal
        }
    }
    
    var circleColor: Color {
        switch size {
        case .minimal:
            return Color.blue
        case .normal:
            switch charactersRemaining{
                case ...0:
                    return Color.red
                default:
                    return Color.yellow
            }
        }
    }
    
    var textColor: Color {
        switch charactersRemaining {
        case ...0:
            return Color.red
        default:
            return Color.secondary
        }
    }
}

extension CharacterProgressRing {
    enum Size {
        case minimal
        case normal
    }
    
    var textFont: Font {
        switch size {
        case .minimal:
            return Font.subheadline.weight(.semibold)
        case .normal:
            return Font.subheadline.weight(.regular)
        }
    }
    
    var radius: CGFloat {
        switch size {
        case .minimal:
            return 19
        case .normal:
            return 25
        }
    }
    
    var lineWidth: CGFloat {
        switch size {
        case .minimal:
            return 3
        case .normal:
            return 3
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        NewTagView(item: MenuItem.example)
    }
}
