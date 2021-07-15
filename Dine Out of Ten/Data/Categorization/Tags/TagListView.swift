//
//  TagListView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/13/21.
//

import Foundation
import OrderedCollections

protocol TagListView {
    associatedtype Item: ObservableObject, Taggable
    
    @ObservedObject var item: Item
    var size: TagListView.Size
    
    init(for item: Item, size: TagViewSize)
    init(with tags: OrderedSet<Tag>, size: TagViewSize)
}

// MARK: TagListView Size
extension TagListView {
    enum Size {
        case small
        case medium
        case large
    }
}

// MARK: TagListView AddTagButton
extension TagListView {
    struct AddTagButton: View {
        
        var size: TagViewSize
        var action: () -> Void
        var tagCount: Int
        
        init(size: TagViewSize, tagCount: Int, action: @escaping () -> Void) {
            self.size = size
            self.action = action
            self.tagCount = tagCount
        }
        
        var body: some View {
            Button(action: action) {
                Text("Add Tag...")
                    .foregroundColor(.accentColor)
                    .font(font)
                    .padding(.horizontal, hPadding)
                    .padding(.vertical, vPadding)
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
    
    func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.item.tags) { tag in
                TagView(for: tag, item: item, deleteable: self.deletable, size: self.size)
                    .padding([.horizontal, .vertical], 2)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        width -= d.width
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        return result
                    })
            }
            
            AddTagButton(size: size, tagCount: item.tags.count) {
                sheetSelection = .NewTagView
            }
            .alignmentGuide(.leading, computeValue: { d in
                if (abs(width - d.width) > g.size.width) {
                    width = 0
                    height -= d.height
                }
                let result = width
                width = 0  // last item in ZStack
                return result
            })
            .alignmentGuide(.top, computeValue: {d in
                let result = height
                height = 0  // last item in ZStack
                return result
            })
            
        }
        .background(viewHeightReader($totalHeight))
    }
}
