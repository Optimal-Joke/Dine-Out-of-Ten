//
//  Dine_Out_of_TenApp.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 11/28/20.
//

import SwiftUI

@main
struct Dine_Out_of_TenApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
