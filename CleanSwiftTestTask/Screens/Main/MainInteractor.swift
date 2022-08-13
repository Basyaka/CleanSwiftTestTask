//
//  MainInteractor.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class MainInteractor {
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
    
    // MARK: - Private Methods
    private func processProductDTOs(
        with productDTOs: [MainDTO.Product],
        imagesData: [String:Data])
    -> [Main.Initial.Response.Product] {
        productDTOs.map { productDTO in
            let imageData = imagesData[productDTO.image] ?? Data()
            
            return Main.Initial.Response.Product(
                productID: productDTO.productID,
                title: productDTO.name,
                price: productDTO.price,
                image: UIImage(data: imageData) ?? UIImage()
            )
        }
    }
    
    private func loadProductImages(with response: MainDTO.Response) {
        self.worker.loadImages(with: response.products) { result in
            switch result {
            case .success(let temporaryStorage):
                let products = self.processProductDTOs(with: response.products, imagesData: temporaryStorage)
                let response = Main.Initial.Response(products: products)
                self.presenter.presentInitialData(response)
            case .failure(let error):
                // display alert with fail
                break
            }
        }
    }
}

// MARK: - MainBusinessLogic
extension MainInteractor: MainBusinessLogic {
    func requestInitialData(_ request: Main.Initial.Request) {
        worker.loadProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.loadProductImages(with: response)
            case .failure(let error):
                // display alert with error
                break
            }
        }
    }
}
