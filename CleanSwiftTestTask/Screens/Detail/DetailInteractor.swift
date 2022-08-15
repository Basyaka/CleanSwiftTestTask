//
//  DetailInteractor.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class DetailInteractor {
    // MARK: - Properties
    var data: Main.DetatilDataTransmissionModel
    
    private let presenter: DetailPresentationLogic
    private let networkWorker: DetailNetworkWorkerLogic
    private let storageWorker: DetailStorageWorkerLogic
    
    // MARK: - Initialization
    init(
        presenter: DetailPresentationLogic,
        networkWorker: DetailNetworkWorkerLogic,
        storageWorker: DetailStorageWorkerLogic,
        data: Main.DetatilDataTransmissionModel
    ) {
        self.presenter = presenter
        self.networkWorker = networkWorker
        self.storageWorker = storageWorker
        self.data = data
    }
    
    // MARK: - Private Methods
    private func updateProductStoredData(with productDTO: DetailDTO.Product) {
        guard let productObject = storageWorker.getProductObject(by: productDTO.productID) else { return }
        if productObject.productDescription == nil {
            storageWorker.updateProduct(productObject, description: productDTO.description)
        }
    }
    
    private func proccessReceivingProductFromStorage(with productID: String) {
        if let product = storageWorker.getProduct(by: productID),
           !product.description.isEmpty {
            let response = Detail.Initial.Response(
                title: product.name,
                description: product.description,
                image: storageWorker.getImage(by: product.productID)
            )
            presenter.presentInitialData(response)
        } else {
            presenter.presentError(Detail.Error.Response())
        }
    }
}

// MARK: - DetailBusinessLogic
extension DetailInteractor: DetailBusinessLogic {
    func requestInitialData(_ request: Detail.Initial.Request) {
        networkWorker.loadProduct(with: data.productID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let product):
                self.updateProductStoredData(with: product)
                self.proccessReceivingProductFromStorage(with: product.productID)
            case .failure:
                self.proccessReceivingProductFromStorage(with: self.data.productID)
            }
        }
    }
    
    func requestError(_ request: Detail.Error.Request) {
        presenter.presentError(Detail.Error.Response())
    }
}
