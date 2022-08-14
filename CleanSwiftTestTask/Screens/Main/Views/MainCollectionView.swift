//
//  MainCollectionView.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import UIKit

final class MainCollectionView: CollectionView {
    // MARK: - Nested Types
    private enum Constants {
        static let normalInset: CGFloat = 16
    }

    // MARK: - Properties
    var callbackDidSelectItem: ((IndexPath) -> Void)?

    var sectionsData: [Main.CollectionView.Section] = [] {
        didSet {
            setupSections()
        }
    }

    // MARK: - Initialization
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        configureCollection()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in SMMainCollectionView")
    }

    // MARK: - Private Methods
    private func configureCollection() {
        registerCells([CollectionViewMainCell.self])
    }

    private func setupSections() {
        sections = sectionsData.map { section in
            let rows: [CollectionViewItemProtocol] = section.items.map { item in
                let cellModel = CollectionViewMainCell.Model(
                    title: item.title,
                    subtitle: item.subtitle,
                    image: item.image
                )
                return CollectionViewItem<CollectionViewMainCell, CollectionViewMainCell.Model>(cellModel)
            }
            return CollectionViewSection(title: section.title, items: rows)
        }
    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth: CGFloat = 20 * (itemsPerRow + 1)
        let availableWidth: CGFloat = collectionView.frame.width - paddingWidth
        let widthPerItem: CGFloat = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        callbackDidSelectItem?(indexPath)
    }
    
    // MARK: - Flow Layout
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Constants.normalInset,
            left: Constants.normalInset,
            bottom: Constants.normalInset,
            right: Constants.normalInset
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.normalInset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.normalInset
    }
}
