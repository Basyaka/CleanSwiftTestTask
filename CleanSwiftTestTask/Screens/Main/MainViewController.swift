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
    }

    // MARK: - Properties
    private let interactor: MainBusinessLogic
    private let router: MainRoutingLogic

    // MARK: - UI Properties

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
        initialData()
    }

    private func configureView() {
        setupSubviews()
        setupLayout()
    }

    private func setupSubviews() {
    }

    private func setupLayout() {
    }

    // MARK: - Interactor Methods
    private func initialData() {
        interactor.requestInitialData(Main.Initial.Request())
    }
}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel) {}
}
