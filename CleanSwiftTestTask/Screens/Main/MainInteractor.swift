//
//  MainInteractor.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class MainInteractor: MainDataStore {
    // MARK: - Properties
    var data: Main.DetatilDataTransmissionModel?
    
    private let presenter: MainPresentationLogic
    private let networkWorker: MainNetworkWorkerLogic
    private let storageWorker: MainStorageWorkerLogic
    
    // MARK: - Initialization
    init(
        presenter: MainPresentationLogic,
        networkWorker: MainNetworkWorkerLogic,
        storageWorker: MainStorageWorkerLogic
    ) {
        self.presenter = presenter
        self.networkWorker = networkWorker
        self.storageWorker = storageWorker
    }
    
    // MARK: - Private Methods
    private func createImageFiles(
        with products: [Main.Initial.Response.Product]
    ) -> [MainDTO.ImageFile] {
        products.map { product in
            MainDTO.ImageFile(image: product.image, path: product.productID)
        }
    }
    
    private func convertProductDTOsToProduct(
        with productDTOs: [MainDTO.Product],
        imagesData: [String:Data])
    -> [Main.Initial.Response.Product] {
        var products: [Main.Initial.Response.Product] = []
        
        productDTOs.forEach { productDTO in
            guard
                let imageData = imagesData[productDTO.image],
                let image = UIImage(data: imageData)
            else { return }
            
            let product = Main.Initial.Response.Product(
                productID: productDTO.productID,
                title: productDTO.name,
                price: productDTO.price,
                image: image
            )
            products.append(product)
        }
        return products
    }
    
    private func saveImages(
        with productDTOs: [MainDTO.Product],
        and temporaryStorage: [String: Data]
    ) {
        let products = convertProductDTOsToProduct(
            with: productDTOs,
            imagesData: temporaryStorage
        )
        let imageFiles = createImageFiles(with: products)
        storageWorker.saveImages(with: imageFiles)
    }
    
    private func loadImages(for productDTOs: [MainDTO.Product]) {
        networkWorker.loadImages(with: productDTOs) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let temporaryDictStorage):
                self.saveImages(with: productDTOs, and: temporaryDictStorage)
                self.loadProductsFromStorage()
            case .failure:
                self.loadProductsFromStorage()
            }
        }
    }
    
    private func loadProductsFromStorage() {
        let productDTOs = storageWorker.getProducts()
        
        if productDTOs.isEmpty {
            presenter.presentError(Main.Error.Response())
            return
        }
        
        let products: [Main.Initial.Response.Product] = productDTOs.map { dto in
            Main.Initial.Response.Product(
                productID: dto.productID,
                title: dto.name,
                price: dto.price,
                image: self.storageWorker.getImage(by: dto.productID)
            )
        }
        
        let response = Main.Initial.Response(products: products)
        presenter.presentInitialData(response)
    }
    
    private func processReceivedProducts(with products: [MainDTO.Product]) {
        storageWorker.proccessProducts(with: products) { [weak self] nonStoredProductDTOs in
            guard let self = self else { return }
            if nonStoredProductDTOs.isEmpty {
                self.loadProductsFromStorage()
            } else {
                self.loadImages(for: nonStoredProductDTOs)
            }
        }
    }
}

// MARK: - MainBusinessLogic
extension MainInteractor: MainBusinessLogic {
    func requestInitialData(_ request: Main.Initial.Request) {
        networkWorker.loadProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.processReceivedProducts(with: response.products)
            case .failure:
                self.loadProductsFromStorage()
            }
        }
    }
    
    func requestDataTransmission(_ request: Main.DataTransmission.Request) {
        data = Main.DetatilDataTransmissionModel(productID: request.productID)
        presenter.presentDataTransmission(Main.DataTransmission.Response())
    }
    
    func requestError(_ request: Main.Error.Request) {
        presenter.presentError(Main.Error.Response())
    }
}
