//
//  DetailViewController.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
    }

    // MARK: - Properties
    private let interactor: DetailBusinessLogic
    private let router: DetailRoutingLogic

    // MARK: - UI Properties

    // MARK: - Initialization
    init(interactor: DetailBusinessLogic, router: DetailRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in DetailViewController")
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
        interactor.requestInitialData(Detail.Initial.Request())
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel) {}
}
