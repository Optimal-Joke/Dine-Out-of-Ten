//
//  TagColorPickerView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/15/21.
//

import SwiftUI

// MARK: TagColorPickerView
struct TagColorPickerView: View {
    @Binding var number: Int
    
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    
    var body: some View {
        if number == 1 {
            OneColorPickerView(color1: $color1)
        } else if number == 2 {
            TwoColorPickerView(color1: $color1, color2: $color2)
        } else if number == 3 {
            ThreeColorPickerView(color1: $color1, color2: $color2, color3: $color3)
        } else if number == 4 {
            FourColorPickerView(color1: $color1, color2: $color2, color3: $color3, color4: $color4)
        }
    }
}

// MARK: ColorPickerViews
struct OneColorPickerView: View {
    @Binding var color1: Color
    
    var body: some View {
        CustomFormEntry {
            ColorPicker("Choose a tag color", selection: $color1)
        }
    }
}

struct TwoColorPickerView: View {
    @Binding var color1: Color
    @Binding var color2: Color
    
    var body: some View {
        CustomFormEntry {
            ColorPicker("Choose tag color 1", selection: $color1)
            ColorPicker("Choose tag color 2", selection: $color2)
        }
    }
}

struct ThreeColorPickerView: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var color3: Color
    
    var body: some View {
        CustomFormEntry {
            ColorPicker("Choose tag color 1", selection: $color1)
            ColorPicker("Choose tag color 2", selection: $color2)
            ColorPicker("Choose tag color 3", selection: $color3)
        }
    }
}

struct FourColorPickerView: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var color4: Color
    
    var body: some View {
        CustomFormEntry {
            ColorPicker("Choose tag color 1", selection: $color1)
            ColorPicker("Choose tag color 2", selection: $color2)
            ColorPicker("Choose tag color 3", selection: $color3)
            ColorPicker("Choose tag color 4", selection: $color4)
        }
    }
}
