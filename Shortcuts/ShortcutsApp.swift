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
    @StateObject var appState = AppState()
    @StateObject var basket = Basket()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(basket)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL { url in
                    if url.host == "openBasket" {
                        appState.latestAction = "openBasket"
                    }
                }
        }
    }
}
