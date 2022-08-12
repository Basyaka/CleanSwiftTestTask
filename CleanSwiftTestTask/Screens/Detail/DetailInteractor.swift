//
//  DetailInteractor.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class DetailInteractor: DetailBusinessLogic {
    // MARK: - Properties
    private let presenter: DetailPresentationLogic
    private let worker: DetailWorkerLogic

    // MARK: - Initialization
    init(
        presenter: DetailPresentationLogic,
        worker: DetailWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - DetailBusinessLogic
    func requestInitialData(_ request: Detail.Initial.Request) {
        self.presenter.presentInitialData(Detail.Initial.Response())
    }
}
