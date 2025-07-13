// Overwrite this file to implement a simple checkout screen for reviewing basket contents
import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var basket: Basket
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmation = false
    
    @State private var selectedPaymentMethod = "Kredi Kartı"
    private let paymentMethods = ["Kredi Kartı", "Kapıda Ödeme", "Yemek Kartı"]
    
    var totalItems: Int {
        basket.orders.reduce(0) { $0 + $1.quantity }
    }
    var totalPrice: Int {
        basket.orders.reduce(0) { $0 + $1.quantity * 10 }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Sipariş Özetin")) {
                HStack {
                    Text("Sepet Sayısı")
                    Spacer()
                    Text("\(totalItems)")
                }
                HStack {
                    Text("Toplam Tutar")
                    Spacer()
                    Text("₺\(totalPrice)")
                }
            }
            
            Section(header: Text("Ödeme Yöntemi")) {
                Picker("Ödeme Yöntemi", selection: $selectedPaymentMethod) {
                    ForEach(paymentMethods, id: \.self) { method in
                        Text(method)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section(header: Text("Teslimat Adresi")) {
                Text("123 Test Address\nSivas, Türkiye")
            }
            
            Section {
                Button(action: {
                    showConfirmation = true
                }) {
                    Text("Pay")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .sheet(isPresented: $showConfirmation, onDismiss: {
            basket.clear()
            dismiss()
        }) {
            VStack(spacing: 28) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.green)
                Text("Ödeme Başarılı!")
                    .font(.title2).bold()
                Button("Tamam") {
                    basket.clear()
                    dismiss()
                }
            }
            .padding()
        }
    }
}

#Preview {
    CheckoutView().environmentObject(Basket())
}
