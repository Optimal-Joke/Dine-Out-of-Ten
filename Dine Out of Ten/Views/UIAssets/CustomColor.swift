//
//  CustomColor.swift
//  CustomColor
//
//  Created by Hunter Holland on 8/23/21.
//

import SwiftUI

public enum AccentColor {
    case red
    case orange
    case green
    case blue
    
    var start: Color {
        switch self {
        case .red:
            return Color("redStart")
        case .orange:
            return Color("orangeStart")
        case .green:
            return Color("greenStart")
        case .blue:
            return Color("blueStart")
        }
    }
    
    var end: Color {
        switch self {
        case .red:
            return Color("redEnd")
        case .orange:
            return Color("orangeEnd")
        case .green:
            return Color("greenEnd")
        case .blue:
            return Color("blueEnd")
        }
    }
}

public enum BackgroundColor {
    case light
    case dark
    
    var start: Color {
        switch self {
        case .light:
            return Color("lightStart")
        case .dark:
            return Color("darkStart")
        }
    }
    
    var end: Color {
        switch self {
        case .light:
            return Color("lightEnd")
        case .dark:
            return Color("darkEnd")
        }
    }
}

public enum ShadowColor {
    case light
    case dark
    
    var start: Color {
        switch self {
        case .light:
            return Color("shadowLightStart")
        case .dark:
            return Color("shadowDarkStart")
        }
    }
    
    var end: Color {
        switch self {
        case .light:
            return Color("shadowLightEnd")
        case .dark:
            return Color("shadowDarkEnd")
        }
    }
}

