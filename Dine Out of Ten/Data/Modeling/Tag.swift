//
//  Tag.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/13/21.
//

import Foundation
import SwiftUI

// MARK: Tag Model
struct Tag: Identifiable {
    let id = UUID()
    var label: String
    var color: LinearGradient
    
    init(label: String, colors: [Color]) {
        self.label = (label == "") ? "🧐 Preview" : label
        self.color = LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}

extension Tag: Equatable, Hashable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        lhs.label == rhs.label
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: TagView
struct TagView<T: Taggable>: View {
    @EnvironmentObject var user: User
    
    var tag: Tag
    var item: T
    var deleteable: Bool
    var size: TagViewSize
    
    @State private var showDeleteWarning = false
    
    init(for tag: Tag, item: T, size: TagViewSize, deleteable: Bool = false) {
        self.tag = tag
        self.item = item
        self.size = size
        self.deleteable = deleteable
    }
    
    func deleteTag() {
        user.removeTag(tag, from: item)
    }
    
    var body: some View {
        HStack {
            Text(tag.label)
                .font(labelFont)
            
            if deleteable {
                Button(action: {
                    showDeleteWarning = true
                }, label: {
                    HStack {
                        Image(systemName: "xmark")
                            .font(xFont)
                    }
                })
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .foregroundColor(.white)
        .background(tag.color)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(.easeInOut(duration: 0.25))
        .alert(isPresented: $showDeleteWarning) {
            Alert(title: Text("Delete Tag"),
                  message: Text("Are you sure you want to delete this item's \"\(tag.label)\" tag?"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("Delete")) {
                        deleteTag()
                  }
            )
        }
        .contextMenu {
            Button(action: {
                showDeleteWarning = true
            }, label: {
                HStack {
                    Text("Delete Tag")
                    Image(systemName: "xmark")
                }
                .foregroundColor(.red)
                .font(xFont)
            })
        }
        .onTapGesture {
            user.addTag(tag, to: item)
        }
    }
    
    var labelFont: Font {
        switch size {
        case .small:
            return Font.caption
        case .medium:
            return Font.callout
        case .large:
            return Font.title3
        }
    }
    
    var xFont: Font {
        switch size {
        case .small:
            return Font.caption.weight(.bold)
        case .medium:
            return Font.callout.weight(.semibold)
        case .large:
            return Font.title3.weight(.semibold)
        }
    }
    
    var horizontalPadding: CGFloat {
        switch size {
        case .small:
            return 8
        case .medium:
            return 10
        case .large:
            return 12
        }
    }
    
    var verticalPadding: CGFloat {
        switch size {
        case .small:
            return 6
        case .medium:
            return 7
        case .large:
            return 8
        }
    }
    
    var cornerRadius: CGFloat {
        switch size {
        case .small:
            return 8
        case .medium:
            return 10
        case .large:
            return 12
        }
    }
}

internal enum TagViewSize {
    case small
    case medium
    case large
}

// MARK: Preview
@available(iOS 15.0, *)
struct Tag_Previews: PreviewProvider {
    static var testTag1 = Tag(label: "🍔 Burger", colors: [.blue])
    static var testTag2 = Tag(label: "🥗 Salad", colors: [.green, .blue])
    static var testTag3 = Tag(label: "🐟 Seafood", colors: [.red, .orange, .yellow])
    static var testTag4 = Tag(label: "🥤 Drink", colors: [.pink, .teal])
    
    static var previews: some View {
        VStack {
            VStack {
                Text("Small")
                    .font(.title2)
                TagView(for: testTag1, item: MenuItem.example, size: .small, deleteable: true)
                TagView(for: testTag2, item: MenuItem.example, size: .small, deleteable: false)
                TagView(for: testTag3, item: MenuItem.example, size: .small, deleteable: true)
                TagView(for: testTag4, item: MenuItem.example, size: .small, deleteable: false)
            }
            
            VStack {
                Text("Medium")
                    .font(.title2)
                TagView(for: testTag1, item: MenuItem.example, size: .medium, deleteable: true)
                TagView(for: testTag2, item: MenuItem.example, size: .medium, deleteable: false)
                TagView(for: testTag3, item: MenuItem.example, size: .medium, deleteable: true)
                TagView(for: testTag4, item: MenuItem.example, size: .medium, deleteable: false)
            }
            
            VStack {
                Text("Large")
                    .font(.title2)
                TagView(for: testTag1, item: MenuItem.example, size: .large, deleteable: true)
                TagView(for: testTag2, item: MenuItem.example, size: .large, deleteable: false)
                TagView(for: testTag3, item: MenuItem.example, size: .large, deleteable: true)
                TagView(for: testTag4, item: MenuItem.example, size: .large, deleteable: false)
            }
        }
    }
}
