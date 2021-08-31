//
//  NeumorphicButtonStyles.swift
//  NeumorphicButtonStyles
//
//  Created by Hunter Holland on 8/23/21.
//

import SwiftUI

enum NeumorphicButtonShape {
    case circle
    case roundedRectangle(cornerRadius: CGFloat)
    
    var value: some Shape {
        switch self {
        case .circle:
            return AnyShape(Circle())
        case .roundedRectangle(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}

protocol HasNeumorphicControls {
    func getStartColor(for colorScheme: ColorScheme) -> Color
    
    func getEndColor(for colorScheme: ColorScheme) -> Color
    
    func getShadowStartColor(for colorScheme: ColorScheme) -> Color
    
    func getShadowEndColor(for colorScheme: ColorScheme) -> Color
}

extension HasNeumorphicControls {
    func getStartColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? BackgroundColor.light.start : BackgroundColor.dark.start
    }
    
    func getEndColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? BackgroundColor.light.start : BackgroundColor.dark.start
    }
    
    func getShadowStartColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? ShadowColor.light.start : ShadowColor.dark.start
    }
    
    func getShadowEndColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? ShadowColor.light.end : ShadowColor.dark.end
    }
}

// MARK: - PlainButtonStyle
struct PlainButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    var shape: NeumorphicButtonShape = .circle
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(getFontColor(for: configuration))
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .contentShape(Circle())
            .background(
                DynamicButtonBackground(isHighlighted: configuration.isPressed, shape: shape.value)
            )
            .animation(nil, value: configuration.isPressed)
    } 
    
    private func getFontColor(for configuration: Self.Configuration) -> Color {
        colorScheme == .light ? Color.gray : Color.white
    }
}

// MARK: - PlainToggleStyle
struct PlainToggleStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorScheme
    var shape: NeumorphicButtonShape = .circle
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .foregroundColor(getFontColor(for: configuration))
                .padding(30)
                .contentShape(Circle())
        }
        .background(
            DynamicButtonBackground(isHighlighted: configuration.isOn, shape: shape.value)
        )
    }
    
    private func getFontColor(for configuration: Self.Configuration) -> Color {
        colorScheme == .light ? Color.gray : Color.white
    }
}

// MARK: - DynamicButtonBackground
struct DynamicButtonBackground<S: Shape>: View, HasNeumorphicControls {
    @Environment(\.colorScheme) var colorScheme
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(endColor, startColor))
                    .overlay(shape.stroke(LinearGradient(startColor, endColor), lineWidth: 4))
                    .shadow(color: shadowStartColor, radius: 10, x: 5, y: 5)
                    .shadow(color: shadowEndColor, radius: 10, x: -5, y: -5)

            } else {
                shape
                    .fill(LinearGradient(startColor, endColor))
                    .overlay(shape.stroke(endColor, lineWidth: 4))
                    .shadow(color: shadowStartColor, radius: 10, x: -10, y: -10)
                    .shadow(color: shadowEndColor, radius: 10, x: 10, y: 10)
            }
        }
    }
    
    private var startColor: Color {
        getStartColor(for: colorScheme)
    }
    
    private var endColor: Color {
        getEndColor(for: colorScheme)
    }
    
    private var shadowStartColor: Color {
        getShadowStartColor(for: colorScheme)
    }
    
    private var shadowEndColor: Color {
        getShadowEndColor(for: colorScheme)
    }
}


// MARK: - ColorfulBackground
struct ColorfulBackground<S: Shape>: View, HasNeumorphicControls {
    @Environment(\.colorScheme) var colorScheme
    var isHighlighted: Bool
    var shape: S
    var color: AccentColor
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(color.start, color.end))
                    .overlay(shape.stroke(LinearGradient(color.start, color.end), lineWidth: 4))
                    .shadow(color: shadowStartColor, radius: 10, x: 5, y: 5)
                    .shadow(color: shadowEndColor, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(startColor, endColor))
                    .overlay(shape.stroke(LinearGradient(color.start, color.end), lineWidth: 4))
                    .shadow(color: shadowStartColor, radius: 10, x: -10, y: -10)
                    .shadow(color: shadowEndColor, radius: 10, x: 10, y: 10)
            }
        }
    }
    
    private var startColor: Color {
        getStartColor(for: colorScheme)
    }
    private var endColor: Color {
        getEndColor(for: colorScheme)
    }
    private var shadowStartColor: Color {
        getShadowStartColor(for: colorScheme)
    }
    private var shadowEndColor: Color {
        getShadowEndColor(for: colorScheme)
    }
}

// MARK: - ColorfulButtonStyle
struct ColorfulButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    var shape: NeumorphicButtonShape = .circle
    var color: AccentColor = .blue
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(getFontColor(for: configuration))
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: shape.value, color: color)
            )
            .animation(nil, value: configuration.isPressed)
    }
    
    private func getFontColor(for configuration: Self.Configuration) -> Color {
        if configuration.isPressed {
            return Color.white
        } else {
            return colorScheme == .light ? Color.gray : Color.white
        }
    }
}

// MARK: - ColorfulToggleStyle
struct ColorfulToggleStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorScheme
    var shape: NeumorphicButtonShape = .circle
    var color: AccentColor = .blue
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .foregroundColor(getFontColor(for: configuration))
                .padding(30)
                .contentShape(Circle())
                .animation(nil, value: configuration.isOn)
        }
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: shape.value, color: color)
        )
    }
    
    private func getFontColor(for configuration: Self.Configuration) -> Color {
        if configuration.isOn {
            return Color.white
        } else {
            return colorScheme == .light ? Color.gray : Color.white
        }
    }
}

// MARK: Preview
private struct Preview: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isToggled = false
    
    var body: some View {
        ZStack {
            LinearGradient(startColor, endColor)
            
            VStack(spacing: 50) {
                VStack(spacing: 50) {
                    Text("Plain")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        print("Button tapped")
                    }) {
                        Label("Hello", systemImage: "heart.fill")
//                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle(shape: .roundedRectangle(cornerRadius: 15)))
                    
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
//                            .foregroundColor(.white)
                    }
                    .toggleStyle(PlainToggleStyle())
                }
                
                VStack(spacing: 50) {
                    Text("Colorful")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        print("Button tapped")
                    }) {
                        Label("Hello", systemImage: "heart.fill")
                    }
                    .buttonStyle(ColorfulButtonStyle(shape: .roundedRectangle(cornerRadius: 15), color: .green))
                    
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                    }
                    .toggleStyle(ColorfulToggleStyle(color: .red))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var startColor: Color {
        colorScheme == .light ? BackgroundColor.light.start : BackgroundColor.dark.start
    }
    
    private var endColor: Color {
        colorScheme == .light ? BackgroundColor.light.start : BackgroundColor.dark.start
    }
}

struct NeumorphicButton2_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
            .preferredColorScheme(.light)
            
            
    }
}
