import SwiftUI

struct IngredientDetailView: View {
    let ingredient: Ingredient
    @State private var info: IngredientNutrition?

    var body: some View {
        ZStack {
            // 🌄 Background Gradient
            LinearGradient(
                colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 🌟 Foreground content
            VStack(spacing: 0) {
                // Main Scrollable Content
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer(minLength: 30)

                        Text(ingredient.name.capitalized)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)

                        AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_250x250/\(ingredient.image)")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 200, height: 200)
                        .cornerRadius(12)

                        if let info = info {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Nutrition per 1 piece:")
                                    .font(.headline)

                                ForEach(info.nutrition?.nutrients ?? []) { nutrient in
                                    Text("\(nutrient.name): \(nutrient.amount, specifier: "%.1f") \(nutrient.unit)")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        } else {
                            ProgressView("Loading nutrition...")
                                .padding()
                        }

                        Spacer(minLength: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }

                // Bottom Dashboard Bar
                HStack {
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "bag.fill")
                            Text("Lunchbox").font(.caption2)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("Ingredient Info")
        .onAppear {
            fetchNutrition()
        }
    }

    private func fetchNutrition() {
        let urlString = "https://api.spoonacular.com/food/ingredients/\(ingredient.id)/information?amount=1&unit=piece&apiKey=daea7e3fdcdd44e89da5e73cbeab82e5"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(IngredientNutrition.self, from: data)
                DispatchQueue.main.async {
                    self.info = decoded
                }
            } catch {
                print("Error decoding ingredient info: \(error)")
            }
        }.resume()
    }
}
