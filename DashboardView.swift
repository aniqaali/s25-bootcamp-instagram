import SwiftUI

struct DashboardView: View {
    var body: some View {
        HStack(spacing: 0) {
            NavigationLink(destination: MainView()) {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
            }

            NavigationLink(destination: IngredientSearchView()) {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
            }

            NavigationLink(destination: LunchboxListView()) {
                VStack {
                    Image(systemName: "bag")
                    Text("Lunchbox")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
            }

            NavigationLink(destination: NutritionTrackerView()) {
                VStack {
                    Image(systemName: "target")
                    Text("Goals")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .bottom)
    }
}
