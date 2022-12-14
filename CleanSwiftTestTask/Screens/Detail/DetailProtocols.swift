//
//  DetailProtocols.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

// MARK: - BusinessLogic
protocol DetailBusinessLogic: AnyObject {
    func requestInitialData(_ request: Detail.Initial.Request)
    func requestError(_ request: Detail.Error.Request)
}

// MARK: - WorkerLogic
protocol DetailNetworkWorkerLogic: AnyObject {
    func loadProduct(
        with stringId: String,
        completion: @escaping ((Result<DetailDTO.Product, HTTPError>) -> Void)
    )
}

protocol DetailStorageWorkerLogic: AnyObject {
    func getProductObject(by primaryKey: String) -> ProductObject?
    func getProduct(by primaryKey: String) -> DetailDTO.Product?
    func updateProduct(_ productObject: ProductObject, description: String)
    func getImage(by path: String) -> UIImage
}

// MARK: - PresentationLogic
protocol DetailPresentationLogic: AnyObject {
    func presentInitialData(_ response: Detail.Initial.Response)
    func presentError(_ response: Detail.Error.Response)
}

// MARK: - DisplayLogic
protocol DetailDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel)
    func displayError(_ viewModel: Detail.Error.ViewModel)
}

// MARK: - RoutingLogic
protocol DetailRoutingLogic: AnyObject {
    func routeToBack()
}
