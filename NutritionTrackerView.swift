import SwiftUI

struct NutritionTrackerView: View {
    @State private var proteinGoal: Double = 100
    @State private var calorieGoal: Double = 2000

    @State private var proteinEaten: Double = 0
    @State private var caloriesEaten: Double = 0

    @State private var proteinInput = ""
    @State private var calorieInput = ""

    var body: some View {
        ZStack{
            LinearGradient(colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 30) {
                        // 🎯 Goal sliders
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Set Your Daily Goals")
                                .font(.headline)

                            VStack(alignment: .leading) {
                                Text("Protein Goal: \(Int(proteinGoal))g")
                                Slider(value: $proteinGoal, in: 0...300, step: 1)
                                    .tint(.orange.opacity(0.3))
                            }

                            VStack(alignment: .leading) {
                                Text("Calorie Goal: \(Int(calorieGoal)) kcal")
                                Slider(value: $calorieGoal, in: 0...5000, step: 10)
                                    .tint(.orange.opacity(0.3))
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)

                        Divider()

                        // 🍽️ Input
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Log Your Intake")
                                .font(.headline)

                            VStack(alignment: .leading) {
                                Text("Protein (g)")
                                TextField("Enter protein eaten", text: $proteinInput)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading) {
                                Text("Calories (kcal)")
                                TextField("Enter calories eaten", text: $calorieInput)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }

                            Button(action: logIntake) {
                                Text("Log Intake")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange.opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)

                        Divider()

                        // Totals and message
                        VStack(spacing: 10) {
                            Text("Today's Totals")
                                .font(.headline)
                            Text("Protein: \(Int(proteinEaten))g")
                            Text("Calories: \(Int(caloriesEaten)) kcal")
                        }

                        if proteinEaten >= proteinGoal && caloriesEaten >= calorieGoal {
                            Text("🎉 Congrats! You've met your daily goal!")
                                .font(.title2)
                                .foregroundColor(.green)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.bottom, 40)
                }

                Divider()

                // ✅ Dashboard added at bottom
                DashboardView()
                
            }
        
        }
        }
      

    private func logIntake() {
        if let addedProtein = Double(proteinInput) {
            proteinEaten += addedProtein
            proteinInput = ""
        }
        if let addedCalories = Double(calorieInput) {
            caloriesEaten += addedCalories
            calorieInput = ""
        }
    }
}

#Preview{
    NutritionTrackerView()
}
