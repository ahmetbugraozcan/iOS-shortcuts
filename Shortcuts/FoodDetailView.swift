// Overwrite this file to implement a food detail and add-to-basket screen
import SwiftUI

struct FoodDetailView: View, Identifiable {
    let id = UUID()
    let food: Food
    @EnvironmentObject var basket: Basket
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIngredients: [Ingredient] = []
    @State private var quantity: Int = 1
    @State private var goToCheckout = false

    private var foodImageView: some View {
        HStack {
            FoodImageView(imageURL: food.imageURL)
                .frame(width: 180, height: 180)
                .background(LinearGradient(gradient: Gradient(colors: food.gradient.map { Color($0) }), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !food.ingredients.isEmpty {
                Text("Ingredients:").font(.headline)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                    ForEach(food.ingredients, id: \.id) { ingredient in
                        let isSelected = selectedIngredients.contains(where: { $0.id == ingredient.id })
                        Button(action: {
                            if isSelected {
                                selectedIngredients.removeAll { $0.id == ingredient.id }
                            } else {
                                selectedIngredients.append(ingredient)
                            }
                        }) {
                            Text(ingredient.name)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(isSelected ? Color.accentColor : Color(.systemGray5))
                                .foregroundStyle(isSelected ? .white : .primary)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var quantityStepper: some View {
        Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    foodImageView

                    if !food.options.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Options:").font(.headline)
                            ForEach(food.options, id: \.self) { option in
                                Text(option)
                                    .font(.subheadline)
                                    .padding(.vertical, 2)
                            }
                        }
                    }

                    Divider()

                    Text(food.description)
                        .font(.body)
                        .foregroundStyle(.secondary)

                    Divider()

                    Text(food.detail)
                        .font(.body)

                    Divider()

                    ingredientsSection

                    quantityStepper

                    NavigationLink(destination: CheckoutView().environmentObject(basket), isActive: $goToCheckout) {
                        EmptyView()
                    }
                    .hidden()

                    Button(action: {
                        basket.add(food: food, selectedIngredients: selectedIngredients, quantity: quantity)
                        dismiss()
                    }) {
                        Text("Add to Basket")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding()
            }
            .navigationTitle(food.name)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    FoodDetailView(food: Food.mockData[0]).environmentObject(Basket())
}
