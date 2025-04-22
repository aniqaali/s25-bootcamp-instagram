
import Foundation


struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let nutrition: RecipeNutrition?
}

