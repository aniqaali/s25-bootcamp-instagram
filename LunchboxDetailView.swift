import SwiftUI

struct LunchboxDetailView: View {
    @ObservedObject var manager = LunchboxManager.shared
    var lunchbox: Lunchbox {
        manager.lunchboxes.first(where: { $0.id == lunchboxID }) ?? Lunchbox(date: Date())
    }
    let lunchboxID: UUID

    var body: some View {
        ZStack {
            // 🟡 Gradient background
            LinearGradient(
                colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // 📦 Foreground content
            VStack {
                // 🧁 Title and lunchbox image
                VStack(spacing: 10) {
                    Text("Lunchbox: \(formatted(lunchbox.date))")
                        .font(.title2)
                        .fontWeight(.bold)

                    Image("lunchbox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .padding(.top, 12)

                // 📝 List of items with remove button
                List {
                    ForEach(lunchbox.items) { item in
                        NavigationLink(
                            destination: {
                                switch item {
                                case .recipe(let recipe):
                                    RecipeDetailView(recipe: recipe)
                                case .ingredient(let ingredient):
                                    IngredientDetailView(ingredient: ingredient)
                                }
                            },
                            label: {
                                HStack {
                                    switch item {
                                    case .recipe(let r):
                                        Text("🍽️ \(r.title)")
                                    case .ingredient(let i):
                                        Text("🧂 \(i.name.capitalized)")
                                    }

                                    Spacer()

                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                        .onTapGesture {
                                            manager.removeItem(item, from: lunchbox)
                                        }
                                }
                                .padding(.vertical, 4)
                            }
                        )
                    }
                }
                .id(lunchbox.id)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color.clear)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatted(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}
