//
//  ShortcutsApp.swift
//  Shortcuts
//
//  Created by Ahmet Buğra Özcan on 13.07.2025.
//

import SwiftUI
import CoreData

@main
struct ShortcutsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
