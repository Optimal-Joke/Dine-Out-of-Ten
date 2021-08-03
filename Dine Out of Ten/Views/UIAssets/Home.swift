//
//  Home.swift
//  Home
//
//  Created by Hunter Holland on 8/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            
            Button {
                self.showSheet = true
            } label: {
                Text("Present Sheet")
            }
            .navigationTitle("Half Modal Sheet")
            .halfSheet(showSheet: $showSheet) {
                // Put your sheet view here
                ZStack {
                    Color.orange
                    
                    VStack {
                        Text("This is inside a sheet!")
                            .font(.title.bold())
                        
                        Button {
                            self.showSheet = false
                        } label: {
                            Text("Dismiss Sheet")
                        }
                    }
                }
                .ignoresSafeArea()
            } onEnd: {
                print("Sheet dismissed")
            }
        }
    }
}

// Custom Half Sheet Modifier....
extension View {
    // Binding Show Variable...
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView, onEnd: @escaping () -> Void = { } ) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: () -> Void
    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            // present modal view
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    
    // On dismiss...
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
}

class CustomHostingController<Content: View>: UIHostingController<Content>{
    override func viewDidLoad() {
//        view.backgroundColor = .clear
        
        // setting presentation controller properties...
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
            presentationController.preferredCornerRadius = 35
        }
    }
}
