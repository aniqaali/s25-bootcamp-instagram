
import Foundation

class LunchboxManager: ObservableObject {
    static let shared = LunchboxManager()
    
    @Published var lunchboxes: [Lunchbox] = []
    
    private init() {}

    func createNewLunchbox(for date: Date = Date()) {
        lunchboxes.append(Lunchbox(date: date))
    }

    func addItem(_ item: LunchItem, to lunchbox: Lunchbox) {
        guard let index = lunchboxes.firstIndex(where: { $0.id == lunchbox.id }) else { return }
        lunchboxes[index].items.append(item)
    }
    func removeItem(_ item: LunchItem, from lunchbox: Lunchbox) {
        guard let index = lunchboxes.firstIndex(where: { $0.id == lunchbox.id }) else { return }
        lunchboxes[index].items.removeAll { $0.id == item.id }
    }

}

