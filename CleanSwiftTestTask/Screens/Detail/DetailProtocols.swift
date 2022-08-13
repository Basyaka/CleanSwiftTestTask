//
//  DetailProtocols.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

// MARK: - BusinessLogic
protocol DetailBusinessLogic: AnyObject {
    func requestInitialData(_ request: Detail.Initial.Request)
}

// MARK: - WorkerLogic
protocol DetailWorkerLogic: AnyObject {
    func loadProduct(
        with stringId: String,
        completion: @escaping ((Result<DetailDTO.Product, HTTPError>) -> Void)
    )
}

// MARK: - PresentationLogic
protocol DetailPresentationLogic: AnyObject {
    func presentInitialData(_ response: Detail.Initial.Response)
}

// MARK: - DisplayLogic
protocol DetailDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel)
}

// MARK: - RoutingLogic
protocol DetailRoutingLogic: AnyObject {}
