//
//  TagView.swift
//  TagView
//
//  Created by Hunter Holland on 7/21/21.
//

import SwiftUI

fileprivate protocol TagViewProtocol: View {
    associatedtype T: Taggable
    
    var tag: Tag { get set }
    var item: T { get set }
    var size: TagViewSize { get set }
    
    init(for tag: Tag, item: T, size: TagViewSize)
}

extension TagViewProtocol {
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
}

struct StaticTagView<T: Taggable>: TagViewProtocol {
    var tag: Tag
    
    var item: T
    
    var size: TagViewSize
    
    init(for tag: Tag, item: T, size: TagViewSize = .small) {
        self.tag = tag
        self.item = item
        self.size = size
    }
    
    var body: some View {
        Text(tag.label)
            .font(labelFont)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .foregroundColor(.white)
            .background(tag.color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - TappableTagView
struct TappableTagView<T: Taggable>: TagViewProtocol {
    var tag: Tag
    
    var item: T
    
    var size: TagViewSize
    
    var addAction: () -> Void = { }
    
    init(for tag: Tag, item: T, size: TagViewSize = .small) {
        self.tag = tag
        self.item = item
        self.size = size
    }
    
    init(for tag: Tag, item: T, size: TagViewSize = .small, addAction: @escaping () -> Void) {
        self.init(for: tag, item: item, size: size)
        self.addAction = addAction
    }
    
    var body: some View {
        Text(tag.label)
            .font(labelFont)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .foregroundColor(.white)
            .background(tag.color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.2)) {
                    addAction()
                }
            }
    }
    
}

// MARK: - DeletableTagView
struct DeletableTagView<T: Taggable>: TagViewProtocol {
    @EnvironmentObject var user: User
    
    var tag: Tag
    
    var item: T
    
    var size: TagViewSize
    
    var deletable: Bool = false
        
    var deleteWithConfirmation: Bool = true
    
    var deleteAction: () -> Void = { }
    
    @State private var showDeletionActionSheet = false
    
    init(for tag: Tag, item: T, size: TagViewSize = .small) {
        self.tag = tag
        self.item = item
        self.size = size
    }
    
    init(for tag: Tag, item: T, size: TagViewSize = .small, deletable: Bool, withDeleteConfirmation: Bool, deleteAction: @escaping () -> Void ) {
        self.init(for: tag, item: item, size: size)
        self.deletable = deletable
        self.deleteWithConfirmation = withDeleteConfirmation
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        HStack {
            Text(tag.label)
                .font(labelFont)
            
            if deletable {
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        deleteWithConfirmation ? showActionSheet() : deleteAction()
                    }
                } label: {
                    HStack {
                        Image(systemName: "xmark")
                            .font(xFont)
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .foregroundColor(.white)
        .background(tag.color)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(.easeOut(duration: 0.2), value: deletable)
        .confirmationDialog("How do you want to remove this tag?", isPresented: $showDeletionActionSheet) {
            Button("Remove Tag from Item") {
                deleteAction()
            }
            
            Button(role: .destructive) {
                deleteTagPermanently()
            } label: {
                Text("Delete Tag Permanently")
            }
        } message: {
            Text("You can remove this tag from this item, or you can delete it entirely. If you delete it, it will remain on any item it is already attached to, but you will no longer be able to add it to new items.")
        }
    }
    
    func showActionSheet() {
        self.showDeletionActionSheet = true
    }
    
    func deleteTagPermanently() {
        user.removeTag(tag, from: item, permanently: true)
    }
}

// MARK: Declaration
//struct TagView<T: Taggable>: View {
//    @EnvironmentObject var user: User
//
//    var tag: Tag
//    var item: T
//    var deleteable: Bool
//    var size: TagViewSize
//
//    @State private var showDeleteWarning = false
//
//    init(for tag: Tag, item: T, size: TagViewSize, deleteable: Bool = false) {
//        self.tag = tag
//        self.item = item
//        self.size = size
//        self.deleteable = deleteable
//    }
//
//    func warnForDeletion() {
//        showDeleteWarning = true
//    }
//
//    func deleteTag() {
//        user.removeTag(tag, from: item)
//    }
//
//    var body: some View {
//        HStack {
//            Text(tag.label)
//                .font(labelFont)
//
//            if deleteable {
//                Button(action: warnForDeletion) {
//                    HStack {
//                        Image(systemName: "xmark")
//                            .font(xFont)
//                    }
//                }
//            }
//        }
//        .padding(.horizontal, horizontalPadding)
//        .padding(.vertical, verticalPadding)
//        .foregroundColor(.white)
//        .background(tag.color)
//        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//        .animation(.easeInOut(duration: 0.25))
//        .alert(isPresented: $showDeleteWarning) {
//            Alert(title: Text("Delete Tag"),
//                  message: Text("Are you sure you want to delete this item's \"\(tag.label)\" tag?"),
//                  primaryButton: .cancel(),
//                  secondaryButton: .destructive(Text("Delete")) {
//                deleteTag()
//            }
//            )
//        }
//        .contextMenu {
//            Button(action: warnForDeletion) {
//                HStack {
//                    Text("Delete Tag")
//                    Image(systemName: "xmark")
//                }
//                .font(xFont)
//            }
//        }
////        .onTapGesture {
////            user.addTag(tag, to: item)
////        }
//    }
//
//    var labelFont: Font {
//        switch size {
//        case .small:
//            return Font.caption
//        case .medium:
//            return Font.callout
//        case .large:
//            return Font.title3
//        }
//    }
//
//    var xFont: Font {
//        switch size {
//        case .small:
//            return Font.caption.weight(.bold)
//        case .medium:
//            return Font.callout.weight(.semibold)
//        case .large:
//            return Font.title3.weight(.semibold)
//        }
//    }
//
//    var horizontalPadding: CGFloat {
//        switch size {
//        case .small:
//            return 8
//        case .medium:
//            return 10
//        case .large:
//            return 12
//        }
//    }
//
//    var verticalPadding: CGFloat {
//        switch size {
//        case .small:
//            return 6
//        case .medium:
//            return 7
//        case .large:
//            return 8
//        }
//    }
//
//    var cornerRadius: CGFloat {
//        switch size {
//        case .small:
//            return 8
//        case .medium:
//            return 10
//        case .large:
//            return 12
//        }
//    }
//}

enum TagViewSize {
    case small
    case medium
    case large
}

// MARK: Preview
struct TagView_Previews: PreviewProvider {
    static var testTag1 = Tag(label: "🍔 Burger", colors: [.blue])
    static var testTag2 = Tag(label: "🥗 Salad", colors: [.green, .blue])
    static var testTag3 = Tag(label: "🐟 Seafood", colors: [.red, .orange, .yellow])
    static var testTag4 = Tag(label: "🥤 Drink", colors: [.pink, .mint])
    
    static var previews: some View {
//        VStack {
//            VStack {
//                Text("Small")
//                    .font(.title2)
//                TagView(for: testTag1, item: MenuItem.example, size: .small, deleteable: true)
//                TagView(for: testTag2, item: MenuItem.example, size: .small, deleteable: false)
//                TagView(for: testTag3, item: MenuItem.example, size: .small, deleteable: true)
//                TagView(for: testTag4, item: MenuItem.example, size: .small, deleteable: false)
//            }
//
//            VStack {
//                Text("Medium")
//                    .font(.title2)
//                TagView(for: testTag1, item: MenuItem.example, size: .medium, deleteable: true)
//                TagView(for: testTag2, item: MenuItem.example, size: .medium, deleteable: false)
//                TagView(for: testTag3, item: MenuItem.example, size: .medium, deleteable: true)
//                TagView(for: testTag4, item: MenuItem.example, size: .medium, deleteable: false)
//            }
//
//            VStack {
//                Text("Large")
//                    .font(.title2)
//                TagView(for: testTag1, item: MenuItem.example, size: .large, deleteable: true)
//                TagView(for: testTag2, item: MenuItem.example, size: .large, deleteable: false)
//                TagView(for: testTag3, item: MenuItem.example, size: .large, deleteable: true)
//                TagView(for: testTag4, item: MenuItem.example, size: .large, deleteable: false)
//            }
//        }
        
        DeletableTagView(for: testTag1, item: MenuItem.example, size: .large, deletable: true, withDeleteConfirmation: false, deleteAction: { })
    }
}
