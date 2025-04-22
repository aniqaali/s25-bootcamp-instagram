
import Foundation
struct Lunchbox: Identifiable, Codable {
    var id: UUID = UUID()
    let date: Date
    var items: [LunchItem] = []
}

enum LunchItem: Identifiable, Codable {
    case recipe(Recipe)
    case ingredient(Ingredient)

    var id: String {
        switch self {
        case .recipe(let r): return "RECIPE-\(r.id)"
        case .ingredient(let i): return "ING-\(i.id)"
        }
    }
}
