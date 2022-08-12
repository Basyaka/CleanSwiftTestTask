//
//  DetailPresenter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class DetailPresenter {
    // MARK: - Properties
    weak var viewController: DetailDisplayLogic?
}

// MARK: - DetailPresentationLogic
extension DetailPresenter: DetailPresentationLogic {
    func presentInitialData(_ response: Detail.Initial.Response) {
        viewController?.displayInitialData(Detail.Initial.ViewModel())
    }
}
