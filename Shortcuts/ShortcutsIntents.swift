import Foundation
import AppIntents

struct OpenBasketIntent: AppIntent {
    static var title: LocalizedStringResource = "Sepeti Aç"
    static var supportedModes: IntentModes = [.foreground]
    @MainActor
    func perform() async throws -> some IntentResult {
        ShortcutBridge.shared.appState?.triggerOpenBasket()
        return .result()
    }
}

struct FilterFoodsByHealthTagIntent: AppIntent {
    static var title: LocalizedStringResource = "Sağlık Etiketine Göre Ara"
    static var supportedModes: IntentModes = [.foreground]

    @Parameter(title: "Etiket")
    var healthTags: [HealthTag]

    func perform() async throws -> some IntentResult {
        ShortcutBridge.shared.appState?.triggerFilterByHealthTag(tag: healthTags.map({ $0.rawValue }))
        return .result()
    }
}

struct FilterFoodsByCategoryIntent: AppIntent {
     
    static var supportedModes: IntentModes = [.foreground, .foreground(.immediate), .background]
    static var title: LocalizedStringResource = "Kategoriye Göre Ara"

    @Parameter(title: "Kategori")
    var category: FoodCategory

    func perform() async throws -> some IntentResult {
        ShortcutBridge.shared.appState?.triggerFilterByCategory(category: category.rawValue)
        return .result()
    }
}

struct FoodAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] = [
        AppShortcut(intent: OpenBasketIntent(), phrases: ["${applicationName} sepetimi aç"]),
        AppShortcut(intent: FilterFoodsByHealthTagIntent(), phrases: ["${applicationName} ile alerjenlere göre ara"]),
        AppShortcut(intent: FilterFoodsByCategoryIntent(), phrases: ["${applicationName} ile kategoriye göre ara"])
    ]
}
