import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var nutrition: RecipeNutrition?
    @State private var recipeInfo: RecipeInfo?

    var body: some View {
        ZStack {
            // 🌄 Background gradient
            LinearGradient(
                colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 📦 Foreground content
            ScrollView {
                VStack(spacing: 16) {
                    Text(recipe.title)
                        .font(.title)
                        .multilineTextAlignment(.center)

                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)

                    if let nutrition = nutrition {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Nutrition")
                                .font(.headline)
                            Text("Calories: \(nutrition.calories)")
                            Text("Carbs: \(nutrition.carbs)")
                            Text("Fat: \(nutrition.fat)")
                            Text("Protein: \(nutrition.protein)")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if let info = recipeInfo {
                        VStack(alignment: .leading, spacing: 12) {
                            if let ready = info.readyInMinutes {
                                Text("⏱ Ready in \(ready) minutes")
                            }
                            if let servings = info.servings {
                                Text("🍽 Servings: \(servings)")
                            }

                            if let instructions = info.analyzedInstructions, !instructions.isEmpty {
                                let steps = instructions[0].steps

                                Text("Instructions")
                                    .font(.headline)
                                    .padding(.top)

                                ForEach(steps) { step in
                                    Text("• \(step.step)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 4)
                                }
                            } else {
                                Text("No instructions provided.")
                                    .italic()
                            }

                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        ProgressView("Loading recipe info...")
                            .padding()
                    }

                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationTitle("Recipe Info")
        .onAppear {
            fetchNutrition()
            fetchRecipeInstructions()
        }
    }

    private func fetchNutrition() {
        let urlString = "https://api.spoonacular.com/recipes/\(recipe.id)/nutritionWidget.json?apiKey=daea7e3fdcdd44e89da5e73cbeab82e5"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(RecipeNutrition.self, from: data)
                DispatchQueue.main.async {
                    self.nutrition = decoded
                }
            } catch {
                print("Error decoding nutrition: \(error)")
            }
        }.resume()
    }

    private func fetchRecipeInstructions() {
        let urlString = "https://api.spoonacular.com/recipes/\(recipe.id)/information?apiKey=daea7e3fdcdd44e89da5e73cbeab82e5"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(RecipeInfo.self, from: data)
                DispatchQueue.main.async {
                    self.recipeInfo = decoded
                }
            } catch {
                print("Error decoding recipe info: \(error)")
            }
        }.resume()
    }
}
