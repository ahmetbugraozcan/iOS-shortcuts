import Foundation
import Combine

struct Order: Identifiable, Hashable, Codable {
    let id: UUID = UUID()
    let food: Food
    let selectedIngredients: [Ingredient]
    var quantity: Int = 1
}

class Basket: ObservableObject {
    @Published var orders: [Order] = []
    
    var count: Int {
        orders.reduce(0) { $0 + $1.quantity }
    }

    func add(food: Food, selectedIngredients: [Ingredient], quantity: Int = 1) {
        if let index = orders.firstIndex(where: { $0.food.id == food.id && $0.selectedIngredients == selectedIngredients }) {
            orders[index].quantity += quantity
        } else {
            orders.append(Order(food: food, selectedIngredients: selectedIngredients, quantity: quantity))
        }
    }
    
    func remove(orderID: UUID) {
        orders.removeAll { $0.id == orderID }
    }
    
    func clear() {
        orders.removeAll()
    }
}
