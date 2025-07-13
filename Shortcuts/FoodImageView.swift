import SwiftUI

struct FoodImageView: View {
    let imageURL: String
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
            @unknown default:
                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview {
    FoodImageView(imageURL: Food.mockData[0].imageURL)
        .frame(width: 100, height: 100)
}
