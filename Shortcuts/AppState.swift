import Foundation
import Combine
import UIKit

class AppState: ObservableObject, ShortcutHandlingAppState {
    @Published var latestAction: String? = nil
    @Published var quickOrderFoodName: String? = nil
    @Published var filterHealthTag: [String?] = []
    @Published var filterCategory: String? = nil
    
    func triggerOpenBasket() {
        latestAction = "openBasket"
        print("Shortcut: Open Basket triggered")
    }

    func triggerFilterByHealthTag(tag: [String?]) {
        filterHealthTag = tag
        latestAction = "filterHealthTag"
        print("Shortcut: Filter by HealthTag: \(tag)")
    }
    func triggerFilterByCategory(category: String) {
        filterCategory = category
        latestAction = "filterCategory"
        print("Shortcut: Filter by Category: \(category)")
    }
}
