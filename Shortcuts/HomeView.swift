import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "house.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundStyle(.blue)
            Text("Welcome Home!")
                .font(.title)
                .bold()
            Text("This is your Home screen.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeView()
}
