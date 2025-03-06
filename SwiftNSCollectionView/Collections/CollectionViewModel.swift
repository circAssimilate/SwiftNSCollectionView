import Foundation
import Combine

class CollectionViewModel: ObservableObject {
    @Published var isLoading: Bool = true {
        didSet {
            print("collectionViewModel.isLoading \(isLoading)")
        }
    }
    @Published var items: [CollectionViewController.Item] = [] {
        didSet {
            updateFilter()
        }
    }
    @Published var filteredItems: [CollectionViewController.Item] = []
    @Published var filter: String = "" {
        didSet {
            updateFilter()
        }
    }
    
    func updateFilter() {
        if filter == "" {
            filteredItems = items
        } else {
            filteredItems = items.filter {
                $0.title.contains(filter)
            }
        }
    }

    func loadInitialItems() {
        Task { @MainActor in
            isLoading = true
            try await Task.sleep(nanoseconds: 2_000_000_000)
            items = [
                CollectionViewController.Item(title: "Item 1"),
                CollectionViewController.Item(title: "Item 2"),
                CollectionViewController.Item(title: "Item 4"),
                CollectionViewController.Item(title: "Item 5"),
                CollectionViewController.Item(title: "Item 6"),
                CollectionViewController.Item(title: "Item 7"),
                CollectionViewController.Item(title: "Item 8"),
                CollectionViewController.Item(title: "Item 9"),
                CollectionViewController.Item(title: "Item 10"),
                CollectionViewController.Item(title: "Item 11"),
                CollectionViewController.Item(title: "Item 12"),
                CollectionViewController.Item(title: "Item 13"),
                CollectionViewController.Item(title: "Item 14"),
                CollectionViewController.Item(title: "Item 15"),
                CollectionViewController.Item(title: "Item 16"),
                CollectionViewController.Item(title: "Item 17"),
                CollectionViewController.Item(title: "Item 18"),
                CollectionViewController.Item(title: "Item 19"),
                CollectionViewController.Item(title: "Item 20"),
                CollectionViewController.Item(title: "Item 21"),
                CollectionViewController.Item(title: "Item 22"),
                CollectionViewController.Item(title: "Item 23"),
                CollectionViewController.Item(title: "Item 24"),
                CollectionViewController.Item(title: "Item 25"),
                CollectionViewController.Item(title: "Item 26"),
                CollectionViewController.Item(title: "Item 27"),
                CollectionViewController.Item(title: "Item 28"),
                CollectionViewController.Item(title: "Item 29"),
                CollectionViewController.Item(title: "Item 30"),
                CollectionViewController.Item(title: "Item 31"),
                CollectionViewController.Item(title: "Item 32"),
                CollectionViewController.Item(title: "Item 33"),
                CollectionViewController.Item(title: "Item 34"),
                CollectionViewController.Item(title: "Item 35"),
                CollectionViewController.Item(title: "Item 36"),
                CollectionViewController.Item(title: "Item 37"),
                CollectionViewController.Item(title: "Item 38"),
                CollectionViewController.Item(title: "Item 39"),
                CollectionViewController.Item(title: "Item 40"),
            ]
            isLoading = false
        }
    }

    func addItem(title: String) {
        items.append(CollectionViewController.Item(title: title))
        objectWillChange.send()
    }
    
    func removeItem(at index: Int) {
        guard index >= 0 && index < items.count else { return }
        items.remove(at: index)
        objectWillChange.send()
    }
}
