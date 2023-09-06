//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 6.09.2023.
//

import SwiftUI

@main
struct WhatsAppCloneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
