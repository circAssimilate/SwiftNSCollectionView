import Cocoa
import SwiftUI

class HostingHeaderView: NSView, NSCollectionViewElement {
    var hostingView: NSHostingView<CollectionHeaderView>?

    func host(viewModel: CollectionViewModel, title: String) {
        let swiftUIView = CollectionHeaderView(viewModel: viewModel, title: title)
        if let hostingView = hostingView {
            hostingView.rootView = swiftUIView
        } else {
            let newHostingView = NSHostingView(rootView: swiftUIView)
            self.hostingView = newHostingView
            addSubview(newHostingView)

            // Set constraints to fill the NSView
            newHostingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newHostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
                newHostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
                newHostingView.topAnchor.constraint(equalTo: topAnchor),
                newHostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
