//
//  NewOrderView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/25/21.
//

import SwiftUI

struct NewOrderView: View {
    var item: MenuItem
    
    @State private var orderRating = 9
    @State private var orderNotes = ""
    @State private var wouldOrderAgain: Bool? = nil
    
    @State private var noteSectionIsShowing = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var possibleRatings = Array(0...10)
    
    var body: some View {
//        NavigationView {
        ZStack {
            Color.accentColor
            
            VStack {
                ZStack(alignment: .topTrailing) {
                    VStack {
                        Text("New order of")
                            .font(.headline.weight(.regular))
                        Text(item.name)
                            .font(.title.weight(.heavy))
                            .multilineTextAlignment(.center)
                        Text("at")
                            .font(.headline.weight(.regular))
                        Text(item.restaurant.name)
                            .font(.title.weight(.heavy))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                    .padding(.bottom, 5)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel")
                                .font(.title3)
                                .foregroundColor(.white)
                        })
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            orderItem()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .font(.title3)
                                .foregroundColor(.white)
                        })
                        .padding()
                    }
                }
                
                Form {
                    Section(header: Text("Rate your order")) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(possibleRatings.reversed(), id: \.self) { i in
                                    Button(action: {
                                        orderRating = i
                                    }, label: {
                                        Text(String(i))
                                            .font(.title)
                                    })
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(i == orderRating ? Color.secondary.opacity(0.2) : Color.clear)
                                    )
                                    .animation(
                                        Animation.easeIn(duration: 0.1)
                                    )
                                }
                            }
                        }
                    }
                    
                    if !noteSectionIsShowing{
                        Button(action: {
                            withAnimation {
                                noteSectionIsShowing.toggle()
                            }
                        }, label: {
                            Text("Add a note...")
                        })
                    } else {
                        TextField("Your thoughts about this order...", text: $orderNotes)
                            .transition(.opacity)
                    }
                    
                    Section(header: Text("Would you order this item again?"),
                            footer: Text("Test foot")) {
                        Picker("Would you order this item again?", selection: $wouldOrderAgain) {
                            Text("❌")
                                .font(.largeTitle)
                            Text(" ⃝")
                            Text("✅")
                                .font(.largeTitle)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            
        }
    }
    
    func orderItem() {
        item.order(withRating: orderRating, atPrice: 0.00, withNotes: orderNotes)
    }
    
//    }
}

struct NewOrder_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView(item: MenuItem.example)
    }
}
