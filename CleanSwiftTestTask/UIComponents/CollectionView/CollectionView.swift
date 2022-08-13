//
//  CollectionView.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import UIKit

class CollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    var sections: [CollectionViewSection] = [] {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }

    init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }

    // MARK: - Setup
    private func setupViews() {
        dataSource = self
        delegate = self
    }

    // MARK: - Register
    func registerCells(_ items: [UICollectionViewCell.Type]) {
        for value in items {
            register(value, forCellWithReuseIdentifier: String(describing: value))
        }
    }

    // MARK: - Methods
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let item = item(at: indexPath) else { fatalError("fatalError: cellForItemAt indexPath") }
        let cellReuseIdentifier = type(of: item).cellReuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        item.configure(view: cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func item(at indexPath: IndexPath) -> CollectionViewItemProtocol? {
        let section = sections[indexPath.section]
        return (section.items.count > indexPath.row) ? section.items[indexPath.row] : nil
    }
}
