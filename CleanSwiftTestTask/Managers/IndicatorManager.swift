//
//  IndicatorManager.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 14.08.22.
//

import UIKit

protocol IndicatorManagerProtocol {
    func showIndicator(for view: UIView)
    func hideIndicator(for view: UIView)
}

final class IndicatorManager: IndicatorManagerProtocol {
    // MARK: - Properties
    static let shared = IndicatorManager()
    
    // MARK: - UI Properties
    private let activityIndicator = UIActivityIndicatorView(style: .medium).prepareForAutoLayout()
    
    // MARK: - Methods
    func showIndicator(for view: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !view.subviews.contains(self.activityIndicator) {
                self.addActivityIndicator(to: view)
            }
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideIndicator(for view: UIView) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func addActivityIndicator(to view: UIView) {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

