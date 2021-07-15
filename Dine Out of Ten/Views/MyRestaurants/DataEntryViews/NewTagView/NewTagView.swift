//
//  NewTagView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/14/21.
//

import SwiftUI

struct NewTagView<T: Taggable>: View {
    @EnvironmentObject var user: User
    
    var item: T
    
    @State var tagName: String = ""
    @State var tagColors: [Color] = [.random()]
    
    let maxCharacters = 20
    
    @State var alertIsShowing: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    @State var error: TagCreationError = .UnknownError
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        TagView(for: Tag(label: tagName, colors: tagColors),
                                item: MenuItem.example,
                                size: .large,
                                deleteable: false)
                            .padding()
                            .offset(x: 0, y: -25)
                        
                        CharacterProgressRing(forText: $tagName,
                                              maxCharacters: maxCharacters)
                            .offset(x: 0, y: 20)
                    }
                    
                    Group {
                        CustomFormEntry("Tag Name") {
                            TextField("Name", text: $tagName)
                        }
                        
                        CustomFormEntry("Color") {
                            ColorPicker("Choose a tag color:", selection: $tagColors[0])
                        }
                    }

//                    Group {
                        
//                        CustomFormEntry("Color", modifiersEnabled: false) {
//                            if #available(iOS 15.0, *) {
//                                Stepper("Number of colors: \(tagColors.count)") {
//                                    if 1...3 ~= tagColors.count {
//                                        addColor()
//                                    }
//                                } onDecrement: {
//                                    if 2...4 ~= tagColors.count {
//                                        removeColor()
//                                    }
//                                }
//                            } else {
//                                // Fallback on earlier versions
//                            }
//                        }
//
//                        CustomFormEntry {
//                            ForEach(tagColors, id: \.self) { color in
//                                let idx = tagColors.firstIndex(where: {$0.hashValue == color.hashValue})!
//                                ColorPicker("Choose tag color \(idx+1):", selection: $tagColors[idx])
//                            }
//                        }
//                    }
                    
//                    Spacer()
                }
                .padding(.horizontal, 15)
                .offset(x: 0, y: 50)
                .navigationTitle(Text("New Tag"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", action: dismissSheet)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add", action: addTag)
                            .disabled(tagName.count > maxCharacters)
                    }
                }
                .alert(isPresented: $alertIsShowing) {
                    Alert(title: error.alertTitle, message: error.alertMessage)
                }
            }
        }
    }
    
    func dismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func addColor() {
//        tagColors.append(.random())
    }
    
    func removeColor() {
//        tagColors.removeLast()
    }
    
    func addTag() {
        let added = self.user.addTag(label: tagName, colors: tagColors, to: item)
        
        if added {
            self.presentationMode.wrappedValue.dismiss()
        } else {
            error = TagCreationError.TagNotUnique
            alertIsShowing = true
        }
    }
}

struct CreateNewTagView_Previews: PreviewProvider {
    static var previews: some View {
        NewTagView(item: MenuItem.example)
    }
}
