import SwiftUI

struct CollectionHeaderView: View {
    @ObservedObject var viewModel: CollectionViewModel
    var title: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: addItem) {
                Text("Add Item")
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
    }

    private func addItem() {
        viewModel.addItem(title: "Header Item")
    }
}
