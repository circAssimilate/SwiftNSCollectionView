import Cocoa
import Combine

class CollectionViewController: NSViewController {
    let viewModel: CollectionViewModel
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Section: Hashable, CustomStringConvertible {
        case header
        case main

        var description: String {
            switch self {
            case .header: return "Header Section"
            case .main: return "Main Section"
            }
        }
    }

    struct Item: Hashable {
        let title: String
        let identifier = UUID() // Adding a unique identifier for diffable collection reasons
    }

    var scrollView: NSScrollView!
    var collectionView: NSCollectionView!
    var dataSource: NSCollectionViewDiffableDataSource<Section, Item>!

    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        view = NSView()
        setupCollectionView()
        setupScrollView()
        setupDataSource()
        bindViewModel()
        viewModel.loadInitialItems()
    }

    private func setupCollectionView() {
        collectionView = NSCollectionView()
        collectionView.delegate = self
        collectionView.collectionViewLayout = createStickyHeaderLayout()
        collectionView.register(HostingCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("HostingCollectionViewItem"))
        collectionView.register(HostingHeaderView.self, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("HostingHeaderView"))
    }

    private func setupScrollView() {
        scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.hasVerticalScroller = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createStickyHeaderLayout() -> NSCollectionViewLayout {
        let layout = StickyHeaderFlowLayout()
        layout.itemSize = NSSize(width: 100, height: 100)
        layout.sectionInset = NSEdgeInsets(top: -30, left: 10, bottom: 10, right: 10)
        layout.headerReferenceSize = NSSize(width: 100, height: 50)
        return layout
    }

    private func setupDataSource() {
        dataSource = NSCollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let collectionViewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("HostingCollectionViewItem"), for: indexPath) as! HostingCollectionViewItem
            collectionViewItem.host(item.title)
            return collectionViewItem
        }

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == NSCollectionView.elementKindSectionHeader else { return nil }
            let headerView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier("HostingHeaderView"), for: indexPath) as! HostingHeaderView
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            guard section == .header else { return nil }

            headerView.host(viewModel: self.viewModel, title: section.description)
            return headerView
        }
    }

    private func bindViewModel() {
        viewModel.$filteredItems
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.applySnapshot(items: items)
            }
            .store(in: &cancellables)
    }

    private func applySnapshot(items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.header, .main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CollectionViewController: NSCollectionViewDelegate {
    // Implement any delegate methods if needed
}
