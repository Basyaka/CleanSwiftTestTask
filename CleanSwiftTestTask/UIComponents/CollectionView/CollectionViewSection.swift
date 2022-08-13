//
//  CollectionViewSection.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

class CollectionViewSection {
    // MARK: - Properties
    private(set) var items: [CollectionViewItemProtocol]
    public let title: String?

    // MARK: - Initialization
    public init(
        title: String? = nil,
        items: [CollectionViewItemProtocol] = []
    ) {
        self.items = items
        self.title = title
    }

    // MARK: - Methods
    func append(contentsOf newElements: [CollectionViewItemProtocol]) {
        items.append(contentsOf: newElements)
    }

    func insert(_ newElement: CollectionViewItemProtocol, at index: Int) {
        items.insert(newElement, at: index)
    }

    func remove(at index: Int) -> CollectionViewItemProtocol {
        return items.remove(at: index)
    }

    func append(_ newElement: CollectionViewItemProtocol) {
        items.append(newElement)
    }
}
