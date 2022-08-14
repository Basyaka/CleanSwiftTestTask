//
//  MainViewController.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit
import SwiftUI

final class MainViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
        static let screenTitle: String = "Main Screen"
    }
    
    // MARK: - Properties
    private let interactor: MainBusinessLogic
    private let router: MainRoutingLogic
    
    private var items: [Main.CollectionView.Item] = []
    
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
        
        requestInitialData()
    }
    
    private func configureView() {
        setupSubviews()
        setupLayout()
        setupActions()
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
    
    private func setupActions() {
        collectionView.callbackDidSelectItem = { [weak self] indexPath in
            guard
                let self = self,
                let item = self.items[safe: indexPath.row]
            else { return }

            let request = Main.DataTransmission.Request(productID: item.productID)
            self.interactor.requestDataTransmission(request)
            self.router.routeToDetail()
        }
    }
    
    private func setupActivityIndicator(state: Bool) {
        if state {
            IndicatorManager.shared.showIndicator(for: view)
        } else {
            IndicatorManager.shared.hideIndicator(for: view)
        }
    }
    
    // MARK: - Interactor Methods
    private func requestInitialData() {
        setupActivityIndicator(state: true)
        interactor.requestInitialData(Main.Initial.Request())
    }
}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel) {
        items = viewModel.products.map { product in
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
        setupActivityIndicator(state: false)
    }
    
    func displayDataTransmission(_ viewModel: Main.DataTransmission.ViewModel) {
    }
    
    func displayError(_ viewModel: Main.Error.ViewModel) {
        setupActivityIndicator(state: false)
        
        let action: (() -> Void) = { [weak self] in
            self?.requestInitialData()
        }
        
        let alertConfigurationModel = AlertManager.ConfigurationModel(
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            buttonText: viewModel.buttonText,
            action: action
        )
        
        AlertManager.showAlert(with: alertConfigurationModel, from: self)
    }
}
