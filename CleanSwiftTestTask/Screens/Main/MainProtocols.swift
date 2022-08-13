//
//  MainProtocols.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

// MARK: - BusinessLogic
protocol MainBusinessLogic: AnyObject {
    func requestInitialData(_ request: Main.Initial.Request)
}

// MARK: - WorkerLogic
protocol MainWorkerLogic: AnyObject {
    func loadProducts(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void))
    func loadImages(
        with products: [MainDTO.Product],
        completion: @escaping (Result<[String:Data], HTTPError>) -> Void
    )
}

// MARK: - PresentationLogic
protocol MainPresentationLogic: AnyObject {
    func presentInitialData(_ response: Main.Initial.Response)
}

// MARK: - DisplayLogic
protocol MainDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel)
}

// MARK: - RoutingLogic
protocol MainRoutingLogic: AnyObject {}
