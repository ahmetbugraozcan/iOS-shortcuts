import Foundation

protocol ShortcutHandlingAppState: AnyObject {
    func triggerOpenBasket()
    func triggerFilterByHealthTag(tag: [String?])
    func triggerFilterByCategory(category: String)
}

final class ShortcutBridge {
    static let shared = ShortcutBridge()
    private init() {}

    weak var appState: ShortcutHandlingAppState?
}
