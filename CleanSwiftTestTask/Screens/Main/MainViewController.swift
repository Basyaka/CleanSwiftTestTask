//
//  MainViewController.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
        static let screenTitle: String = "Main Screen"
    }
    
    // MARK: - Properties
    private let interactor: MainBusinessLogic
    private let router: MainRoutingLogic
    
    // MARK: - UI Properties
    private let collectionView = MainCollectionView().prepareForAutoLayout()
    
    // MARK: - Initialization
    init(interactor: MainBusinessLogic, router: MainRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in MainViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        startSettings()
    }
    
    // MARK: - Private Methods
    private func startSettings() {
        title = Constants.screenTitle
        view.backgroundColor = .white
        
        initialData()
    }
    
    private func configureView() {
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Interactor Methods
    private func initialData() {
        interactor.requestInitialData(Main.Initial.Request())
    }
}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel) {
        let items: [Main.CollectionView.Item] = viewModel.products.map { product in
            Main.CollectionView.Item(
                productID: product.productID,
                title: product.title,
                subtitle: product.price,
                image: product.image
            )
        }
        
        let sections: [Main.CollectionView.Section] = [
            Main.CollectionView.Section(title: String.empty, items: items)
        ]
        
        collectionView.sectionsData = sections
    }
}
