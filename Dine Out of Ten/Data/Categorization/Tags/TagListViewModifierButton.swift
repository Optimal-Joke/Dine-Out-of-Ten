//
//  TagListViewModifierButton.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/13/21.
//

import SwiftUI

typealias TagListViewModifierButton = TagListModifierButton & View


protocol TagListModifierButton {
    var size: TagViewSize { get set }
    var tagCount: Int { get set }
    var labelMode: TagListModifierButtonMode { get set }
    var action: () -> Void { get set }
    
    
}

extension TagListModifierButton {
    var body: some View {
        Button(buttonLabel, action: action)
            .foregroundColor(.black)
            .font(font)
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)
    }
    
    var buttonLabel: String {
        switch labelMode {
        case .dynamic(primaryLabel: let primary, secondaryLabel: let secondary):
            return tagCount != 0 ? primary : secondary
        case .stable(label: let label):
            return label
        }
    }
    
    var font: Font {
        switch size {
        case .small:
            return Font.subheadline
        case .medium:
            return Font.body
        case .large:
            return Font.title3
        }
    }
    
    var vPadding: CGFloat {
        switch size {
        case .small:
            return tagCount == 0 ? 1 : 6.5
        case .medium:
            return tagCount == 0 ? 1 : 8.5
        case .large:
            return tagCount == 0 ? 1 : 10.5
        }
    }
    
    var hPadding: CGFloat {
        switch size {
        case .small:
            return tagCount == 0 ? 1 : 6
        case .medium:
            return tagCount == 0 ? 1 : 6
        case .large:
            return tagCount == 0 ? 1 : 6
        }
    }
}

enum TagListModifierButtonMode {
    case dynamic(primaryLabel: String, secondaryLabel: String)
    case stable(label: String)
}
