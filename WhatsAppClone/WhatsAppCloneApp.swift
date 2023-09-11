//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 6.09.2023.
//

import SwiftUI
import FirebaseCore

@main
struct WhatsAppCloneApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
