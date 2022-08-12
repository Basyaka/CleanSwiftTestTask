//
//  MainInteractor.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class MainInteractor: MainBusinessLogic {
    // MARK: - Properties
    private let presenter: MainPresentationLogic
    private let worker: MainWorkerLogic

    // MARK: - Initialization
    init(
        presenter: MainPresentationLogic,
        worker: MainWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - MainBusinessLogic
    func requestInitialData(_ request: Main.Initial.Request) {
        worker.loadProducts { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                break
            }
        }
        self.presenter.presentInitialData(Main.Initial.Response())
    }
}
