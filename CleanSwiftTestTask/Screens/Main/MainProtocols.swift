//
//  MainProtocols.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation
import UIKit

// MARK: - BusinessLogic
protocol MainBusinessLogic: AnyObject {
    func requestInitialData(_ request: Main.Initial.Request)
    func requestDataTransmission(_ request: Main.DataTransmission.Request)
    func requestError(_ request: Main.Error.Request)
}

// MARK: - WorkerLogic
protocol MainNetworkWorkerLogic: AnyObject {
    func loadProducts(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void))
    func loadImages(
        with products: [MainDTO.Product],
        completion: @escaping (Result<[String:Data], HTTPError>) -> Void
    )
}

protocol MainStorageWorkerLogic: AnyObject {
    func proccessProducts(
        with productDTOs: [MainDTO.Product],
        completion: @escaping (([MainDTO.Product]) -> Void)
    )
    
    func getProducts() -> [MainDTO.Product]
    func saveImages(with imageFiles: [MainDTO.ImageFile])
    func getImage(by path: String) -> UIImage
}

// MARK: - PresentationLogic
protocol MainPresentationLogic: AnyObject {
    func presentInitialData(_ response: Main.Initial.Response)
    func presentDataTransmission(_ response: Main.DataTransmission.Response)
    func presentError(_ response: Main.Error.Response)
}

// MARK: - DisplayLogic
protocol MainDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel)
    func displayDataTransmission(_ viewModel: Main.DataTransmission.ViewModel)
    func displayError(_ viewModel: Main.Error.ViewModel)
}

// MARK: - RoutingLogic
protocol MainRoutingLogic: AnyObject {
    func routeToDetail()
}

// MARK: - DataStore
protocol MainDataStore: AnyObject {
    var data: Main.DetatilDataTransmissionModel? { get set }
}
