//
//  NewTagViewPage.swift
//  NewTagViewPage
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI

struct NewTagViewPage<T: Taggable>: View {
    @EnvironmentObject var user: User
    
    var item: T
    
    @State private var tagName: String = ""
    @State private var numberOfColors: Int = 1
    
    @State var color1: Color = .random
    @State var color2: Color = .random
    @State var color3: Color = .random
    @State var color4: Color = .random
    
    let maxCharacters = 20
    
    @State private var alertIsShowing: Bool = false
    
    @State private var error: TagCreationError?
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    StaticTagView(for: Tag(label: tagName, colors: makeColorArray()),
                               item: MenuItem.example)
                        .padding()
                        .offset(x: 0, y: -25)
                    
                    CharacterProgressRing(forText: $tagName,
                                          maxCharacters: maxCharacters)
                        .offset(x: 0, y: 20)
                }
                
                CustomFormEntry("Tag Name") {
                    TextField("Name", text: $tagName)
                }
                
                Group {
                    CustomFormEntry("Color", modifiersEnabled: false) {
                        Stepper("Number of Colors: \(numberOfColors)", value: $numberOfColors, in: 1...4)
                    }
                    
                    TagColorPickerView(number: $numberOfColors,
                                       color1: $color1, color2: $color2, color3: $color3, color4: $color4)
                }
            }
            .padding(.horizontal, 15)
            .offset(x: 0, y: 50)
            .navigationTitle(Text("New Tag"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: addTag)
                        .disabled(tagName.count > maxCharacters)
                }
            }
            .alert(isPresented: $alertIsShowing) {
                Alert(title: error!.alertTitle, message: error!.alertMessage)
            }
        }
        
    }
    
    func dismissPage() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func makeColorArray() -> [Color] {
        let tagColors: [Color]
        
        switch numberOfColors {
        case 1:
            tagColors = [color1]
        case 2:
            tagColors = [color1, color2]
        case 3:
            tagColors = [color1, color2, color3]
        case 4:
            tagColors = [color1, color2, color3, color4]
        default:
            tagColors = []
        }
        
        return tagColors
    }
    
    func addTag() {
        defer {
            if error != nil { alertIsShowing = true }
        }
        
        do {
            let tagColors = makeColorArray()
            let newTag = Tag(label: tagName, colors: tagColors)
            try user.addTag(newTag, to: item)
        } catch is TagCreationError {
            self.error = error
        } catch {
            self.error = TagCreationError.UnknownError
        }
    }
}

struct NewTagViewPage_Previews: PreviewProvider {
    static var previews: some View {
        NewTagViewPage(item: MenuItem.example)
            .environmentObject(User(testOrdersPerItem: 10))
    }
}
