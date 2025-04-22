import SwiftUI

enum SearchType: String, CaseIterable {
    case recipes = "Recipes"
    case ingredients = "Ingredients"
}

struct IngredientSearchView: View {
    @State private var query = ""
    @State private var selectedSearchType: SearchType = .recipes
    @State private var recipes: [Recipe] = []
    @State private var ingredients: [Ingredient] = []

    var body: some View {
        ZStack {
            // 🟡 Yellow gradient background
            LinearGradient(
                colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 🌐 Main content
            VStack(spacing: 0) {
                NavigationStack {
                    VStack(spacing: 16) {
                        Spacer(minLength: (recipes.isEmpty && ingredients.isEmpty) ? 80 : 0)

                        Text("Start Cooking")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top)

                        Picker("Search Type", selection: $selectedSearchType) {
                            ForEach(SearchType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 300)
                        .padding()

                        HStack {
                            TextField("Search \(selectedSearchType.rawValue.lowercased())", text: $query)
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)

                            Button(action: performSearch) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(10)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(maxWidth: 500)
                        .padding(.horizontal)

                        ScrollView {
                            VStack(spacing: 10) {
                                if selectedSearchType == .recipes {
                                    ForEach(recipes) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            HStack {
                                                AsyncImage(url: URL(string: recipe.image)) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Color.gray.opacity(0.2)
                                                }
                                                .frame(width: 60, height: 60)
                                                .cornerRadius(8)

                                                Text(recipe.title)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)

                                                Spacer()

                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.green)
                                                    .font(.title2)
                                                    .onTapGesture {
                                                        if let todayBox = LunchboxManager.shared.lunchboxes.last {
                                                            LunchboxManager.shared.addItem(.recipe(recipe), to: todayBox)
                                                        }
                                                    }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                } else {
                                    ForEach(ingredients) { item in
                                        NavigationLink(destination: IngredientDetailView(ingredient: item)) {
                                            HStack {
                                                AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(item.image)")) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Color.gray.opacity(0.2)
                                                }
                                                .frame(width: 60, height: 60)
                                                .cornerRadius(8)

                                                Text(item.name.capitalized)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)

                                                Spacer()

                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.green)
                                                    .font(.title2)
                                                    .onTapGesture {
                                                        if let todayBox = LunchboxManager.shared.lunchboxes.last {
                                                            LunchboxManager.shared.addItem(.ingredient(item), to: todayBox)
                                                        }
                                                    }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }

                                Color.clear.frame(height: 60) // padding for dashboard
                            }
                            .padding(.top)
                        }
                        .scrollIndicators(.visible)
                        .scrollDismissesKeyboard(.interactively)

                        Spacer(minLength: 10)
                    }
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(edges: .bottom)
                }

                DashboardView()
            }
        }
    }

    private func performSearch() {
        if selectedSearchType == .recipes {
            SpoonacularAPIManager.shared.searchRecipes(query: query) { fetched in
                self.recipes = fetched
            }
        } else {
            SpoonacularAPIManager.shared.searchIngredients(query: query) { fetched in
                self.ingredients = fetched
            }
        }
    }
}
