//
//  DetailInteractorTests.swift
//  CleanSwiftTestTaskTests
//
//  Created by Vlad Novik on 14.08.22.
//

import XCTest
import UIKit
@testable import CleanSwiftTestTask

class DetailInteractorTests: XCTestCase {
    private var sut: DetailInteractor!
    private var presenter: DetailPresenterSpy!
    private var networkWorker: DetailNetworkWorkerMock!
    private var storageWorker: DetailStorageWorkerMock!
    
    override func setUp() {
        super.setUp()
        presenter = DetailPresenterSpy()
        networkWorker = DetailNetworkWorkerMock()
        storageWorker = DetailStorageWorkerMock()
        sut = DetailInteractor(
            presenter: presenter,
            networkWorker: networkWorker,
            storageWorker: storageWorker,
            data: Main.DetatilDataTransmissionModel(productID: "1")
        )
    }
    
    override func tearDown() {
        presenter = nil
        networkWorker = nil
        storageWorker = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    func testErrorPresentetionWhenDescriptionEmpty() {
        // if server return error
        networkWorker.isErrorStatus = true
        // if description empty in storage
        storageWorker.product = DetailDTO.Product(
            productID: "",
            name: "",
            price: 0,
            image: "",
            description: ""
        )
        
        sut.requestInitialData(Detail.Initial.Request())
        
        XCTAssert(presenter.didCallErrorAlert)
    }
    
    func testErrorPresentetionWhenDescriptionExist() {
        // if server return error
        networkWorker.isErrorStatus = true
        // if description empty in storage
        storageWorker.product = DetailDTO.Product(
            productID: "",
            name: "",
            price: 0,
            image: "",
            description: "notEmpty"
        )
        
        sut.requestInitialData(Detail.Initial.Request())
        
        XCTAssert(presenter.didPresentInitialData)
    }
    
    func testUpdatingProductDescription() {
        // if server return success
        networkWorker.isErrorStatus = false
        // if productObject does't have description
        storageWorker.productObject = ProductObject(
            productID: "",
            name: "",
            price: 0,
            imagePath: "",
            productDescription: nil
        )
        
        sut.requestInitialData(Detail.Initial.Request())
        
        XCTAssert(storageWorker.updateProductDidCall)
    }
    
    func testPresentingWhenServerReturnSuccess() {
        // if server return success
        networkWorker.isErrorStatus = false
        // if product exist
        storageWorker.product = DetailDTO.Product(
            productID: "",
            name: "",
            price: 0,
            image: "",
            description: ""
        )
        
        sut.requestInitialData(Detail.Initial.Request())
        
        XCTAssert(presenter.didPresentInitialData)
    }
}

private final class DetailPresenterSpy: DetailPresentationLogic {
    var didCallErrorAlert: Bool = false
    var didPresentInitialData: Bool = false
    
    func presentInitialData(_ response: Detail.Initial.Response) {
        didPresentInitialData = true
    }
    
    func presentError(_ response: Detail.Error.Response) {
        didCallErrorAlert = true
    }
}

private final class DetailNetworkWorkerMock: DetailNetworkWorkerLogic {
    var isErrorStatus: Bool = false
    
    func loadProduct(
        with stringId: String,
        completion: @escaping ((Result<DetailDTO.Product, HTTPError>) -> Void)
    ) {
        if isErrorStatus {
            return completion(.failure(.networkError(NSError())))
        } else {
            let product = DetailDTO.Product(
                productID: "",
                name: "",
                price: 0,
                image: "",
                description: ""
            )
            return completion(.success(product))
        }
        
    }
}

private final class DetailStorageWorkerMock: DetailStorageWorkerLogic {
    var productObject: ProductObject? = nil
    var product: DetailDTO.Product? = nil
    var updateProductDidCall: Bool = false
    
    func getProductObject(by primaryKey: String) -> ProductObject? { productObject }
    
    func getProduct(by primaryKey: String) -> DetailDTO.Product? { product }
    
    func updateProduct(_ productObject: ProductObject, description: String) {
        updateProductDidCall = true
    }
    
    func getImage(by path: String) -> UIImage { UIImage() }
}
