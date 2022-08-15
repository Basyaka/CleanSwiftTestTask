//
//  DetailPresenter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class DetailPresenter {
    // MARK: - Nested Types
    private enum Constants {
        // TODO: - Extract strings to the localization files .string
        static let errorTitle: String = "Error!"
        static let errorSubtitle: String = "Sorry, we're working on it. Try later."
        static let buttonText: String = "Ok"
    }
    
    // MARK: - Properties
    weak var viewController: DetailDisplayLogic?
}

// MARK: - DetailPresentationLogic
extension DetailPresenter: DetailPresentationLogic {
    func presentInitialData(_ response: Detail.Initial.Response) {
        let viewModel = Detail.Initial.ViewModel(
            title: response.title,
            description: response.description,
            image: response.image
        )
        viewController?.displayInitialData(viewModel)
    }
    
    func presentError(_ response: Detail.Error.Response) {
        let viewModel = Detail.Error.ViewModel(
            title: Constants.errorTitle,
            subtitle: Constants.errorSubtitle,
            buttonText: Constants.buttonText
        )
        viewController?.displayError(viewModel)
    }
}
