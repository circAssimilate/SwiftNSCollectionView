//
//  ContentView.swift
//  SwiftNSCollectionView
//
//  Created by Derek Hammond on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var collectionViewModel = CollectionViewModel()
    
    var body: some View {
        HSplitView {
            SidebarView(viewModel: collectionViewModel)
                .frame(minWidth: 150, idealWidth: 166, maxWidth: 200)
            ZStack {
                DeadCenterView {
                    CenteredSpinner()
                }
                .opacity(collectionViewModel.isLoading ? 1 : 0)
                CollectionView(collectionViewModel: collectionViewModel)
                    .opacity(collectionViewModel.isLoading ? 0 : 1)
            }
            .animation(.easeInOut(duration: 0.2), value: collectionViewModel.isLoading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 800, height: 600)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

struct CollectionView: NSViewRepresentable {
    let collectionViewModel: CollectionViewModel
    init(collectionViewModel: CollectionViewModel) {
        self.collectionViewModel = collectionViewModel
    }
    
    func makeCoordinator() -> CollectionViewController {
        return CollectionViewController(viewModel: collectionViewModel)
    }
    
    func makeNSView(context: Context) -> NSView {
        context.coordinator.view
    }

    func updateNSView(_ view: NSView, context _: Context) {
        // Do nothing here
    }
}

#Preview {
    ContentView()
}
