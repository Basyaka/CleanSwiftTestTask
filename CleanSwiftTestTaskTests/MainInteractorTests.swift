//
//  MainInteractorTests.swift
//  CleanSwiftTestTaskTests
//
//  Created by Vlad Novik on 14.08.22.
//

import XCTest
import UIKit
@testable import CleanSwiftTestTask

class MainInteractorTests: XCTestCase {
    private var sut: MainInteractor!
    private var presenter: MainPresenterSpy!
    private var networkWorker: MainNetworkWorkerMock!
    private var storageWorker: MainStorageWorkerMock!
    
    override func setUp() {
        super.setUp()
        presenter = MainPresenterSpy()
        networkWorker = MainNetworkWorkerMock()
        storageWorker = MainStorageWorkerMock()
        sut = MainInteractor(
            presenter: presenter,
            networkWorker: networkWorker,
            storageWorker: storageWorker
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
    func testErrorPresentetionWhenNoDataAvailable() {
        // if server return error
        networkWorker.isErrorStatusForLoadProducts = true
        // if local storage empty
        storageWorker.stubProducts = []
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(presenter.didCallErrorAlert)
    }
    
    func testErrorPresentationWhenDataExist() {
        // if server return error
        networkWorker.isErrorStatusForLoadProducts = true
        // if local storage existing data
        storageWorker.stubProducts = [
            MainDTO.Product(productID: "", name: "", price: 0, image: "")
        ]
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(!presenter.didCallErrorAlert)
    }
    
    func testInitialDataPresentationWhenServerReturnErrorAndLocalStorageEmpty() {
        // if server return error
        networkWorker.isErrorStatusForLoadProducts = true
        // if local storage empty
        storageWorker.stubProducts = []
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(!presenter.didPresentInitialData)
    }
    
    func testInitialDataPresentationWhenServerReturnSuccessButLocalStorageEmpty() {
        // if server return success
        networkWorker.isErrorStatusForLoadProducts = false
        // if local storage empty
        storageWorker.stubProducts = []
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(!presenter.didPresentInitialData)
    }
    
    func testInitialDataPresentationWhenServerReturnSuccessAndLocalStorageExist() {
        // if server return success
        networkWorker.isErrorStatusForLoadProducts = false
        // if local storage exist
        storageWorker.stubProducts = [
            MainDTO.Product(productID: "", name: "", price: 0, image: "")
        ]
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(presenter.didPresentInitialData)
    }
    
    func testSavingAndPresentingNewItems() {
        // if server return success
        networkWorker.isErrorStatusForLoadProducts = false
        // if images loading siccess
        networkWorker.isErrorStatusForLoadProducts = false
        // if local storage exist
        storageWorker.stubProducts = [
            MainDTO.Product(productID: "", name: "", price: 0, image: "")
        ]
        // if received new items
        storageWorker.nonStoredProducts = [
            MainDTO.Product(productID: "", name: "", price: 0, image: "")
        ]
        
        sut.requestInitialData(Main.Initial.Request())
        
        XCTAssert(storageWorker.isImagesDidSaved)
        XCTAssert(presenter.didPresentInitialData)
    }
}

private final class MainPresenterSpy: MainPresentationLogic {
    var didCallErrorAlert: Bool = false
    var didPresentInitialData: Bool = false
    
    func presentInitialData(_ response: Main.Initial.Response) {
        didPresentInitialData = true
    }
    
    func presentDataTransmission(_ response: Main.DataTransmission.Response) {}
    
    func presentError(_ response: Main.Error.Response) {
        didCallErrorAlert = true
    }
}

private final class MainNetworkWorkerMock: MainNetworkWorkerLogic {
    var isErrorStatusForLoadProducts: Bool = false
    var isErrorStatusForLoadImages: Bool = false
    
    func loadProducts(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void)) {
        let products: [MainDTO.Product] = []
        
        let response = MainDTO.Response(products: products)
        
        if isErrorStatusForLoadProducts {
            return completion(.failure(.networkError(NSError())))
        } else {
            return completion(.success(response))
        }
    }
    
    func loadImages(
        with products: [MainDTO.Product],
        completion: @escaping (Result<[String:Data], HTTPError>) -> Void
    ) {
        if isErrorStatusForLoadImages {
            return completion(.failure(.networkError(NSError())))
        } else {
            return completion(.success([:]))
        }
    }
}

private final class MainStorageWorkerMock: MainStorageWorkerLogic {
    var stubProducts: [MainDTO.Product] = []
    var nonStoredProducts: [MainDTO.Product] = []
    var isImagesDidSaved: Bool = false
    
    func proccessProducts(
        with productDTOs: [MainDTO.Product],
        completion: @escaping (([MainDTO.Product]) -> Void)
    ) {
        completion(nonStoredProducts)
    }
    
    func getProducts() -> [MainDTO.Product] { stubProducts }
    
    func saveImages(with imageFiles: [MainDTO.ImageFile]) {
        isImagesDidSaved = true
    }
    
    func getImage(by path: String) -> UIImage { UIImage() }
}
