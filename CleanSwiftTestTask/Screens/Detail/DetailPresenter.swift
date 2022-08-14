//
//  DetailPresenter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class DetailPresenter {
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
}
