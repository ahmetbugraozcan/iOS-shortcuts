import SwiftUI

struct FoodsListView: View {
    @EnvironmentObject var basket: Basket
    @EnvironmentObject var appState: AppState
    let allFoods: [Food] = Food.mockData

    @State private var selectedCategory: FoodCategory? = nil
    @State private var selectedHealthTags: Set<HealthTag> = []
    @State private var searchText: String = ""

    private var filteredFoods: [Food] {
        allFoods.filter { food in
            let categoryMatch = selectedCategory == nil || food.category == selectedCategory
            let healthTagMatch = selectedHealthTags.isEmpty || selectedHealthTags.isSubset(of: Set(food.healthTags))
            let textMatch = searchText.isEmpty ||
                food.name.localizedCaseInsensitiveContains(searchText) ||
                food.description.localizedCaseInsensitiveContains(searchText)
            return categoryMatch && healthTagMatch && textMatch
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                categorySelectionView
                healthTagSelectionView
                searchBarView
                foodsListView
            }
            .onReceive(appState.$latestAction) { action in
                if action == "filterCategory",
                   let raw = appState.filterCategory {
                    selectedCategory = FoodCategory(rawValue: raw)
                }
                
                if action == "filterHealthTag" {
                    var set: Set<HealthTag> = []
                    appState.filterHealthTag.forEach { value in
                        guard let value, let tag = HealthTag(rawValue: value) else { return }
                        set.insert(tag)
                    }
                    selectedHealthTags = set
                }
            }
            .navigationTitle("Yemekler")
            .toolbar {
                NavigationLink(destination: BasketView().environmentObject(basket)) {
                    HStack {
                        Image(systemName: "cart")
                        Text("Sepet (\(basket.count))")
                    }
                }
            }
        }
    }

    // MARK: – Atomik Alt Görünümler

    private var categorySelectionView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Button("Tümü") {
                        selectedCategory = nil
                    }
                    .id("all")
                    .categoryButtonStyle(isSelected: selectedCategory == nil)

                    ForEach(FoodCategory.allCases) { category in
                        Button(category.localizedName) {
                            selectedCategory = category
                        }
                        .id(category.rawValue)
                        .categoryButtonStyle(isSelected: selectedCategory == category)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .onChange(of: selectedCategory) { newCat in
                let targetID = newCat?.rawValue ?? "all"
                withAnimation {
                    proxy.scrollTo(targetID, anchor: .center)
                }
            }
        }
    }

    private var healthTagSelectionView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(HealthTag.allCases, id: \.self) { tag in
                        let isSel = selectedHealthTags.contains(tag)
                        Button(tag.displayName) {
                            if isSel { selectedHealthTags.remove(tag) }
                            else    { selectedHealthTags.insert(tag) }
                        }
                        .id(tag.rawValue)
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(isSel ? Color.accentColor : Color(.systemGray6))
                        .foregroundStyle(isSel ? .white : .primary)
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }.onChange(of: selectedHealthTags) { newTags in
                let targetID = newTags.first?.rawValue
                withAnimation {
                    proxy.scrollTo(targetID, anchor: .center)
                }
            }
        }
    }

    private var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Yemek veya açıklama ara", text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray5).opacity(0.85))
        .cornerRadius(12)
        .padding([.horizontal, .bottom], 12)
        .padding(.top, 2)
    }

    private var foodsListView: some View {
        List(filteredFoods) { food in
            NavigationLink(destination: FoodDetailView(food: food).environmentObject(basket)) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(food.name).font(.headline)
                        Spacer()
                        Text("₺\(food.price, specifier: "%.2f")")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    Text(food.description)
                        .font(.subheadline).foregroundStyle(.secondary)
                    HStack(spacing: 6) {
                        Text(food.category.localizedName)
                            .font(.caption2).bold()
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Color(.systemGray4)).clipShape(Capsule())
                        ForEach(food.healthTags, id: \.self) { tag in
                            Text(tag.displayName)
                                .font(.caption2)
                                .padding(.horizontal, 6).padding(.vertical, 2)
                                .background(Color(.systemGray5)).clipShape(Capsule())
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .listStyle(.plain)
    }
}

private extension View {
    func categoryButtonStyle(isSelected: Bool) -> some View {
        self
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(isSelected ? Color.accentColor : Color(.systemGray5))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
    }
}
