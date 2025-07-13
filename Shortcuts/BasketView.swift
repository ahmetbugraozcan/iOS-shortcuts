import SwiftUI

struct BasketView: View {
    @EnvironmentObject var basket: Basket
    @State private var showCheckout = false

    var totalItems: Int {
        basket.orders.reduce(0) { $0 + $1.quantity }
    }
    var totalPrice: Int {
        basket.orders.reduce(0) { $0 + $1.quantity * 10 }
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Sepet").font(.headline).padding(.top, 4)) {
                    ForEach(basket.orders) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top, spacing: 12) {
                                FoodImageView(imageURL: order.food.imageURL)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(order.food.name)
                                            .font(.headline)
                                        Spacer()
                                        Text("x\(order.quantity)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    if !order.food.options.isEmpty {
                                        Text(order.food.options.joined(separator: ", "))
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    if !order.food.detail.isEmpty {
                                        Text(order.food.detail)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    if !order.selectedIngredients.isEmpty {
                                        Text("İçindekiler: " + order.selectedIngredients.map { $0.name }.joined(separator: ", "))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            Divider()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Sepet")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") { }
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    HStack {
                        Text("Sepet sayısı: \(totalItems)")
                            .font(.subheadline).bold()
                        Spacer()
                        Text("Tutar: ₺\(totalPrice)")
                            .font(.subheadline).bold()
                    }
                    .padding(.horizontal)

                    Button(action: {
                        showCheckout = true
                    }) {
                        Text("Ödeme Yap")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding([.horizontal, .bottom])
                }
                .background(.bar)
            }
            .sheet(isPresented: $showCheckout) {
                CheckoutView()
                    .environmentObject(basket)
            }
        }
    }
}

#Preview {
    BasketView().environmentObject(Basket())
}
