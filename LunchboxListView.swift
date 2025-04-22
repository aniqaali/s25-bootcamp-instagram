import SwiftUI

struct LunchboxListView: View {
    @ObservedObject var manager = LunchboxManager.shared

    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            
            VStack(spacing: 0) {
                NavigationStack {
                    List {
                        ForEach(manager.lunchboxes) { lunchbox in
                            NavigationLink(destination: LunchboxDetailView(lunchboxID: lunchbox.id)) {
                                HStack {
                                    Image("lunchbox")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text(dateLabel(for: lunchbox.date))
                                }
                                .padding()
                            }
                            .listRowBackground(Color.orange.opacity(0.3))
                           
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color.clear)
                    .navigationTitle("My Lunchboxes")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                manager.createNewLunchbox()
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }

             
                DashboardView()
            }
        }
    }

    func dateLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
