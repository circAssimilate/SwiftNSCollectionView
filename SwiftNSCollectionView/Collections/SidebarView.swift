import SwiftUI

struct SidebarView: View {
    @ObservedObject var viewModel: CollectionViewModel

    var body: some View {
        VStack {
            HStack {
                Button(
                    action: {
                        addItem()
                    },
                    label: {
                        Text("Add Item")
                            .frame(maxWidth: .infinity)
                    }
                )
                Button(
                    action: {
                        viewModel.isLoading.toggle()
                    },
                    label: {
                        Text("Loading")
                            .frame(maxWidth: .infinity)
                    }
                )
            }
            Divider()
            VStack {
                ScrollView {
                    Button(
                        action: {
                            viewModel.filter = ""
                        },
                        label: {
                            Text("All Items")
                                .frame(maxWidth: .infinity)
                        }
                    )
                    Button(
                        action: {
                            viewModel.filter = "Sidebar"
                        },
                        label: {
                            Text("Sidebar Items")
                                .frame(maxWidth: .infinity)
                        }
                    )
                    Button(
                        action: {
                            viewModel.filter = "Header"
                        },
                        label: {
                            Text("Header Items")
                                .frame(maxWidth: .infinity)
                        }
                    )
                }
            }
        }
        .padding()
    }

    private func addItem() {
        viewModel.addItem(title: "Sidebar Item")
    }
}

// Provide conformance to Identifiable:
extension CollectionViewController.Item: Identifiable {
    var id: UUID { identifier }
}
