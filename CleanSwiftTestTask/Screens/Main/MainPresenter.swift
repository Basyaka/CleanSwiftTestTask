//
//  MainPresenter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class MainPresenter {
    // MARK: - Properties
    weak var viewController: MainDisplayLogic?
}

// MARK: - MainPresentationLogic
extension MainPresenter: MainPresentationLogic {
    func presentInitialData(_ response: Main.Initial.Response) {
        viewController?.displayInitialData(Main.Initial.ViewModel())
    }
}
