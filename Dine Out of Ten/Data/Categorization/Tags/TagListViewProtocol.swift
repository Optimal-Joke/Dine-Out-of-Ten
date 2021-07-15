//
//  TagListView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 7/13/21.
//

import SwiftUI
import OrderedCollections

// MARK: TagListView Protocol
protocol TagListView: View {
    associatedtype Item: ObservableObject, Taggable
    var size: TagViewSize { get }
    var trailingButtonAction: () -> Void { get set }
    
    var item: Item { get set }
    
    var totalHeight: CGFloat { get set }
    
    init(for item: Item, size: TagViewSize, trailingButtonAction: @escaping () -> Void)
}

extension TagListView {
    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}


// MARK: TagListViewTrailingButton
struct TagListViewTrailingButton: TagListViewModifierButton {
    var size: TagViewSize
    
    var tagCount: Int
    
    var labelMode: TagListModifierButtonMode
    
    var action: () -> Void
}

struct ItemTagListViewTrailingButton: TagListViewModifierButton {
    var size: TagViewSize
    
    var tagCount: Int
    
    var labelMode: TagListModifierButtonMode
        
    var action: () -> Void
}


// MARK: UserTagListView
struct UserTagListView<T>: TagListView where T: ObservableObject, T: Taggable {
    var size: TagViewSize
    var editMode: Bool = true
    var trailingButtonAction: () -> Void
    
    @EnvironmentObject var user: User
    @ObservedObject var item: T
    @State var totalHeight: CGFloat = 0
    
    init(for item: T, size: TagViewSize = .small, trailingButtonAction: @escaping () -> Void) {
        self.item = item
        self.size = size
        self.trailingButtonAction = trailingButtonAction
    }
    
    init(for item: T, size: TagViewSize = .small, editing: Bool, trailingButtonAction: @escaping () -> Void) {
        self.init(for: item, size: size, trailingButtonAction: trailingButtonAction)
        self.editMode = editing
    }
    
    var tags: OrderedSet<Tag> {
        switch item {
        case _ as Restaurant:
            return editMode ? user.restaurantTags.subtracting(item.tags) : user.restaurantTags
        case _ as MenuItem:
            return editMode ? user.menuItemTags.subtracting(item.tags) : user.menuItemTags
        default:
            return []
        }
    }
}

extension UserTagListView {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags) { tag in
                TagView(for: tag, item: item, size: size)
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
            
            TagListViewTrailingButton(size: size, tagCount: tags.count, labelMode: .stable(label: "New Tag..."), action: trailingButtonAction)
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


// MARK: ItemTagListView
struct ItemTagListView<T>: TagListView where T: ObservableObject, T: Taggable {
    var size: TagViewSize
    var deleteable: Bool = false
    var trailingButtonMode: TagListModifierButtonMode = .stable(label: "Add Tag...")
    var trailingButtonAction: () -> Void
    
    @ObservedObject var item: T
    @State var totalHeight: CGFloat = 0
    @State private var sheetSelection: DataEntryView? = nil
    
    init(for item: T, size: TagViewSize = .medium, trailingButtonAction: @escaping () -> Void) {
        self.item = item
        self.size = size
        self.trailingButtonAction = trailingButtonAction
    }
    
    init(for item: T, size: TagViewSize = .medium, deleteable: Bool, trailingButtonAction: @escaping () -> Void) {
        self.init(for: item, size: size, trailingButtonAction: trailingButtonAction)
        self.deleteable = deleteable
    }
    
    init(for item: T, size: TagViewSize = .medium, deleteable: Bool = false, trailingButtonMode: TagListModifierButtonMode, trailingButtonAction: @escaping () -> Void) {
        self.init(for: item, size: size, deleteable: deleteable, trailingButtonAction: trailingButtonAction)
        self.trailingButtonMode = trailingButtonMode
    }
}

extension ItemTagListView {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
        .sheet(item: $sheetSelection) { selectedTarget in
            switch selectedTarget {
            case .NewTagView:
                NewTagView(item: item)
            default:
                EmptyView()
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.item.tags) { tag in
                TagView(for: tag, item: item, size: size, deleteable: deleteable)
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
            
            TagListViewTrailingButton(size: size, tagCount: item.tags.count, labelMode: trailingButtonMode, action: trailingButtonAction)
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
