import Foundation

class SpoonacularAPIManager {
    static let shared = SpoonacularAPIManager()
    private let apiKey = "daea7e3fdcdd44e89da5e73cbeab82e5"

    
    func searchRecipes(query: String, completion: @escaping ([Recipe]) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(query)&number=10"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Recipe decoding failed: \(error)")
            }
        }.resume()
    }

    func searchIngredients(query: String, completion: @escaping ([Ingredient]) -> Void) {
        let urlString = "https://api.spoonacular.com/food/ingredients/search?apiKey=\(apiKey)&query=\(query)&number=10"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(IngredientSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Ingredient decoding failed: \(error)")
            }
        }.resume()
    }
}

struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}

struct IngredientSearchResponse: Codable {
    let results: [Ingredient]
}
