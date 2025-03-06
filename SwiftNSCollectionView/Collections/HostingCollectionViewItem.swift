import Cocoa
import SwiftUI

class HostingCollectionViewItem: NSCollectionViewItem {
    var hostingView: NSHostingView<CollectionItemView>?

    override func loadView() {
        view = NSView()
    }

    func host(_ title: String) {
        let swiftUIView = CollectionItemView(title: title)
        if let hostingView = hostingView {
            hostingView.rootView = swiftUIView
        } else {
            let newHostingView = NSHostingView(rootView: swiftUIView)
            self.hostingView = newHostingView
            view.addSubview(newHostingView)

            // Set constraints to make the hosting view fill the NSCollectionViewItem's view
            newHostingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newHostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                newHostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                newHostingView.topAnchor.constraint(equalTo: view.topAnchor),
                newHostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}
