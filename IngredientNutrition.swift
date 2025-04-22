import Foundation

struct IngredientNutrition: Codable {
    let id: Int
    let name: String
    let amount: Double?
    let unit: String?
    let nutrition: NutritionInfo?
}

struct NutritionInfo: Codable {
    let nutrients: [Nutrient]
}
struct Nutrient: Codable, Identifiable {
    var id: Int { name.hashValue }
    let name: String
    let amount: Double
    let unit: String
}
