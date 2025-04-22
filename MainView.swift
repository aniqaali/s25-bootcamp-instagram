import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                    startPoint: .top,
                    endPoint: .bottom
                )
              

                VStack {
                    Spacer()

                    // Centered animation/logo
                    ShakingBowlView()
                   

                    // Bottom right button
                    HStack {
                        Spacer()
                        NavigationLink(destination: IngredientSearchView()) {
                            HStack(spacing: 6) {
                                Text("Start Cooking")
                                Image(systemName: "arrow.right.circle.fill")
                            }
                            .foregroundColor(.black)
                            .cornerRadius(20)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 30)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainView()
}
