import Foundation
import AppIntents

struct Ingredient: Codable, Equatable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let icon: String?
    let isOptional: Bool
    
    static let mockIngredients: [Ingredient] = [
        Ingredient(id: UUID(), name: "Tavuk", icon: "🍗", isOptional: false),
        Ingredient(id: UUID(), name: "Marul", icon: "🥬", isOptional: false),
        Ingredient(id: UUID(), name: "Domates", icon: "🍅", isOptional: false),
        Ingredient(id: UUID(), name: "Fındık", icon: "🌰", isOptional: true),
        Ingredient(id: UUID(), name: "Ekmek", icon: "🍞", isOptional: true),
        Ingredient(id: UUID(), name: "Yoğurt", icon: "🥛", isOptional: true)
    ]
}

// MARK: - FoodCategory Enum
nonisolated enum FoodCategory: String, AppEnum, Codable, CaseIterable, Identifiable {
    case mainCourse
    case dessert
    case drink
    case salad
    case snack
    case breakfast
    case soup

    var localizedName: String {
        switch self {
        case .mainCourse: return NSLocalizedString("Ana Yemek", comment: "Kategori: Ana Yemek")
        case .dessert: return NSLocalizedString("Tatlı", comment: "Kategori: Tatlı")
        case .drink: return NSLocalizedString("İçecek", comment: "Kategori: İçecek")
        case .salad: return NSLocalizedString("Salata", comment: "Kategori: Salata")
        case .snack: return NSLocalizedString("Atıştırmalık", comment: "Kategori: Atıştırmalık")
        case .breakfast: return NSLocalizedString("Kahvaltı", comment: "Kategori: Kahvaltı")
        case .soup: return NSLocalizedString("Çorba", comment: "Kategori: Çorba")
        }
    }
    
    // 1) `Identifiable.id` artık non-isolated
    var id: String { rawValue }

    // 2) AppEntity gereği tip adı
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Kategori")

    // 3) Liste elemanı gösterimi de non-isolated
    static var caseDisplayRepresentations: [FoodCategory: DisplayRepresentation] = [
        .mainCourse: "Ana Yemek",
        .dessert:    "Tatlı",
        .drink:      "İçecek",
        .salad:      "Salata",
        .snack:      "Atıştırmalık",
        .breakfast:  "Kahvaltı",
        .soup:       "Çorba"
    ]
}

// MARK: - HealthTag Enum
nonisolated enum HealthTag: String, AppEnum, Codable, Identifiable, Hashable {
    case vegan
    case glutenFree
    case lowCarb
    case highProtein
    case nutFree
    case containsNuts
    case organic
    case dairyFree
    case spicy
    case vegetarian

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .vegan: return NSLocalizedString("Vegan", comment: "Sağlık Tagı: Vegan")
        case .glutenFree: return NSLocalizedString("Glutensiz", comment: "Sağlık Tagı: Glutensiz")
        case .lowCarb: return NSLocalizedString("Düşük Karbonhidrat", comment: "Sağlık Tagı: Düşük Karbonhidrat")
        case .highProtein: return NSLocalizedString("Yüksek Protein", comment: "Sağlık Tagı: Yüksek Protein")
        case .nutFree: return NSLocalizedString("Fındıksız", comment: "Sağlık Tagı: Fındıksız")
        case .containsNuts: return NSLocalizedString("Fındıklı", comment: "Sağlık Tagı: Fındıklı")
        case .organic: return NSLocalizedString("Organik", comment: "Sağlık Tagı: Organik")
        case .dairyFree: return NSLocalizedString("Süt İçermez", comment: "Sağlık Tagı: Süt İçermez")
        case .spicy: return NSLocalizedString("Baharatlı", comment: "Sağlık Tagı: Baharatlı")
        case .vegetarian: return NSLocalizedString("Vejetaryan", comment: "Sağlık Tagı: Vejetaryan")
        }
    }

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Kategori")

    static var caseDisplayRepresentations: [HealthTag: DisplayRepresentation] = [
        .vegan: "Vegan",
        .glutenFree: "Glutensiz",
        .lowCarb: "Düşük Karbonhidrat",
        .highProtein: "Yüksek Protein",
        .nutFree: "Fındıksız",
        .containsNuts: "Fındıklı",
        .organic: "Organik",
        .dairyFree: "Süt İçermez",
        .spicy: "Baharatlı",
        .vegetarian: "Vejetaryan"
    ]
}

struct Food: Codable, Equatable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    let calories: Int
    let price: Double

    let imageURL: String
    let gradient: [String]
    let ingredients: [Ingredient]
    let options: [String]
    let detail: String

    var category: FoodCategory
    var healthTags: [HealthTag]

    static let mockData: [Food] = [
        Food(
            id: UUID(),
            name: "Izgara Tavuk Göğsü",
            description: "Taze otlarla marine edilmiş yumuşak ızgara tavuk göğsü.",
            calories: 220,
            price: 9.99,
            imageURL: "https://source.unsplash.com/featured/?chicken",
            gradient: ["#FFDEB6", "#FFB4AB"],
            ingredients: [Ingredient.mockIngredients[0], Ingredient.mockIngredients[1]],
            options: ["Ekstra Sos", "Tuzsuz"],
            detail: "Taze otlarla hafifçe baharatlanmış ızgara tavuk.",
            category: .mainCourse,
            healthTags: [.highProtein, .lowCarb, .glutenFree, .nutFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Sezar Salata",
            description: "Romaine marullu ve parmesan peynirli klasik Sezar salata.",
            calories: 180,
            price: 7.49,
            imageURL: "https://source.unsplash.com/featured/?salad",
            gradient: ["#D0F0C0", "#A8E6CF"],
            ingredients: [Ingredient.mockIngredients[1], Ingredient.mockIngredients[2]],
            options: ["Kruton Ekle", "Ekstra Sos"],
            detail: "Taze romaine marul, parmesan ve kremalı Sezar sos ile.",
            category: .salad,
            healthTags: [.vegetarian, .nutFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Çikolatalı Brownie",
            description: "Cevizli zengin çikolatalı brownie.",
            calories: 350,
            price: 4.99,
            imageURL: "https://source.unsplash.com/featured/?brownie",
            gradient: ["#7B3F00", "#B5651D"],
            ingredients: [Ingredient.mockIngredients[3], Ingredient.mockIngredients[5]],
            options: ["Dondurma Ekle", "Kuruyemişsiz"],
            detail: "Çıtır cevizli leziz çikolatalı brownie.",
            category: .dessert,
            healthTags: [.vegetarian, .containsNuts, .organic]
        ),
        Food(
            id: UUID(),
            name: "Taze Portakal Suyu",
            description: "Katkısız, taze sıkılmış portakal suyu.",
            calories: 110,
            price: 3.99,
            imageURL: "https://source.unsplash.com/featured/?orange-juice",
            gradient: ["#FFA500", "#FFD580"],
            ingredients: [Ingredient.mockIngredients[2]],
            options: ["Buz Ekle", "Posasız"],
            detail: "Taze sıkılmış portakallardan hazırlanan ferahlatıcı portakal suyu.",
            category: .drink,
            healthTags: [.vegan, .glutenFree, .dairyFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Baharatlı Tofu Sote",
            description: "Sebzeli ve baharatlı soslu tofu sote.",
            calories: 280,
            price: 8.50,
            imageURL: "https://source.unsplash.com/featured/?tofu",
            gradient: ["#FF6F61", "#FF9671"],
            ingredients: [Ingredient.mockIngredients[1], Ingredient.mockIngredients[2]],
            options: ["Daha Acı", "Pilav Ekle"],
            detail: "Taze sebzelerle lezzetli baharatlı sos içinde sote edilmiş tofu.",
            category: .mainCourse,
            healthTags: [.vegan, .glutenFree, .spicy, .dairyFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Avokado Tost",
            description: "Tam tahıllı tost üzerine ezilmiş avokado ve pul biber.",
            calories: 250,
            price: 6.75,
            imageURL: "https://source.unsplash.com/featured/?avocado-toast",
            gradient: ["#A3D2CA", "#5EAAA8"],
            ingredients: [Ingredient.mockIngredients[4], Ingredient.mockIngredients[2]],
            options: ["Yumurta Ekle", "Ekstra Pul Biber"],
            detail: "Kremamsı ezilmiş avokado ve hafif baharatla tamamlanmış tam tahıllı tost.",
            category: .breakfast,
            healthTags: [.vegan, .glutenFree, .dairyFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Minestrone Çorbası",
            description: "Fasulye ve makarna içeren doyurucu sebze çorbası.",
            calories: 150,
            price: 5.25,
            imageURL: "https://source.unsplash.com/featured/?soup",
            gradient: ["#F2D7D9", "#D9E4DD"],
            ingredients: [Ingredient.mockIngredients[1], Ingredient.mockIngredients[2]],
            options: ["Peynir Ekle", "Ekstra Makarna"],
            detail: "Fasulye, makarna ve taze sebzelerle zenginleştirilmiş klasik İtalyan sebze çorbası.",
            category: .soup,
            healthTags: [.vegetarian, .nutFree, .organic]
        ),
        Food(
            id: UUID(),
            name: "Bademli Granola Bar",
            description: "Badem ve bal içeren çıtır granola bar.",
            calories: 190,
            price: 2.99,
            imageURL: "https://source.unsplash.com/featured/?granola-bar",
            gradient: ["#FFE9B1", "#FFB347"],
            ingredients: [Ingredient.mockIngredients[3], Ingredient.mockIngredients[4]],
            options: ["Çikolata Parçacıkları Ekle", "Glutensiz"],
            detail: "Badem dolu ve hafif bal aromalı tatlı çıtır granola bar.",
            category: .snack,
            healthTags: [.vegetarian, .containsNuts, .highProtein, .organic]
        ),
        Food(
            id: UUID(),
            name: "Yunan Yoğurtlu Parfe",
            description: "Yunan yoğurdu, meyveler ve granola katmanları.",
            calories: 220,
            price: 5.99,
            imageURL: "https://source.unsplash.com/featured/?yogurt-parfait",
            gradient: ["#D4F1F4", "#75E6DA"],
            ingredients: [Ingredient.mockIngredients[5], Ingredient.mockIngredients[4]],
            options: ["Bal Ekle", "Ekstra Meyve"],
            detail: "Kremamsı Yunan yoğurdu, taze meyveler ve çıtır granola katmanları.",
            category: .breakfast,
            healthTags: [.vegetarian, .glutenFree, .highProtein, .organic]
        ),
        Food(
            id: UUID(),
            name: "Fıstık Ezmeli Smoothie",
            description: "Fıstık ezmesi, muz ve badem sütü ile kremamsı smoothie.",
            calories: 320,
            price: 6.50,
            imageURL: "https://source.unsplash.com/featured/?peanut-butter-smoothie",
            gradient: ["#FAD7A0", "#F9D976"],
            ingredients: [Ingredient.mockIngredients[3], Ingredient.mockIngredients[5]],
            options: ["Protein Tozu Ekle", "Şekersiz"],
            detail: "Fıstık ezmesini muz ve badem sütü ile harmanlayan yumuşak ve kremsi smoothie.",
            category: .drink,
            healthTags: [.vegetarian, .glutenFree, .highProtein, .containsNuts]
        )
    ]
}
