//
//  TagView.swift
//  TagView
//
//  Created by Hunter Holland on 7/21/21.
//

import SwiftUI

fileprivate protocol TagView: View {
    associatedtype T: Taggable
    
    var tag: Tag { get set }
    var item: T { get set }
    
    init(for tag: Tag, item: T)
}

fileprivate protocol TagViewRepresentable: View { }

struct TagButtonView<T: Taggable>: TagView, TagViewRepresentable {
    var tag: Tag
    var item: T

    init(for tag: Tag, item: T) {
        self.tag = tag
        self.item = item
    }
    
    var body: some View {
        Button(tag.label, role: .destructive) {
            
        }
        .buttonStyle(.borderedProminent)
        .tint(tag.colors[0])
        .controlSize(.small)
        .cornerRadius(5)
    }
}

struct AddTagButton: TagViewRepresentable {
    var body: some View {
        Button("Add Tag...") {
            showAddTagView()
        }
        .controlSize(.small)
    }
    
    func showAddTagView() {
        
    }
}

// MARK: - StaticTagView
struct StaticTagView<T: Taggable>: TagView {
    var tag: Tag
    var item: T
    
    init(for tag: Tag, item: T) {
        self.tag = tag
        self.item = item
    }
    
    var body: some View {
        Text(tag.label)
            .foregroundColor(.white)
            .background(tag.color)
    }
}

// MARK: - TappableTagView
struct TappableTagView<T: Taggable>: TagView {
    var tag: Tag
    var item: T
    
    var addAction: () -> Void = { }
    
    init(for tag: Tag, item: T) {
        self.tag = tag
        self.item = item
    }
    
    init(for tag: Tag, item: T, addAction: @escaping () -> Void) {
        self.init(for: tag, item: item)
        self.addAction = addAction
    }
    
    var body: some View {
        Text(tag.label)
            .foregroundColor(.white)
            .background(tag.color)
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.2)) {
                    addAction()
                }
            }
    }
    
}

// MARK: - DeletableTagView
struct DeletableTagView<T: Taggable>: TagView {
    @EnvironmentObject var user: User
    
    var tag: Tag
    var item: T
    var deletable: Bool = false
    var deleteWithConfirmation: Bool = true
    var deleteAction: () -> Void = { }
    
    @State private var showDeletionActionSheet = false
    
    init(for tag: Tag, item: T) {
        self.tag = tag
        self.item = item
    }
    
    init(for tag: Tag, item: T, deletable: Bool, withDeleteConfirmation: Bool, deleteAction: @escaping () -> Void ) {
        self.init(for: tag, item: item)
        self.deletable = deletable
        self.deleteWithConfirmation = withDeleteConfirmation
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        HStack {
            Text(tag.label)
            
            if deletable {
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        deleteWithConfirmation ? showActionSheet() : deleteAction()
                    }
                } label: {
                    HStack {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .foregroundColor(.white)
        .background(tag.color)
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
        TagCloud(for: MenuItem.example)
//        ButtonTagView(for: MenuItem.example.tags[0], item: MenuItem.example)
//            .padding()
    }
}
