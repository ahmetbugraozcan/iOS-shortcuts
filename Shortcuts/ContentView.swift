import SwiftUI


struct ContentView: View {
    @StateObject var basket = Basket()
    @StateObject var appState = AppState()
    @State private var showBasket = false

    var body: some View {
        NavigationStack {
            FoodsListView()
                .environmentObject(basket)
                .environmentObject(appState)
        }
        .onAppear { ShortcutBridge.shared.appState = appState }
        .onReceive(appState.$latestAction) { action in
            print("onrecieve latestaction is \(action) in contentview")
            if action == "openBasket" {
                showBasket = true
            }
        }
        .sheet(isPresented: $showBasket) {
            BasketView().environmentObject(basket)
        }
    }
}
