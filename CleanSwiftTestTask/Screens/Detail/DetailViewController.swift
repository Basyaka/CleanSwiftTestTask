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
        static let screenTitle: String = "Detail Screen"
        static let contentOffset: CGFloat = 16
    }

    // MARK: - Properties
    private let interactor: DetailBusinessLogic
    private let router: DetailRoutingLogic

    // MARK: - UI Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView.prepareForAutoLayout()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let subtitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel,
            subtitileLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView.prepareForAutoLayout()
    }()
    
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
        title = Constants.screenTitle
        view.backgroundColor = .white
       
        requestInitialData()
    }

    private func configureView() {
        setupSubviews()
        setupLayout()
    }

    private func setupSubviews() {
        view.addSubview(contentStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.contentOffset),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentOffset),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentOffset),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.contentOffset),
            
            imageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.8)
        ])
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
        interactor.requestInitialData(Detail.Initial.Request())
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel) {
        titleLabel.text = viewModel.title
        subtitileLabel.text = viewModel.description
        imageView.image = viewModel.image
        setupActivityIndicator(state: false)
    }
    
    func displayError(_ viewModel: Detail.Error.ViewModel) {
        setupActivityIndicator(state: false)
        
        let action: (() -> Void) = { [weak self] in
            self?.router.routeToBack()
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
