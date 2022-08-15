//
//  MainStorageWorker.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import Foundation
import RealmSwift
import UIKit

final class MainStorageWorker {
    // MARK: - Properties
    private let realmService: RealmService
    private let fileService: FileServiceProtocol
    
    // MARK: - Initialization
    init(
        realmService: RealmService = StorageContainer.shared.realmService,
        fileService: FileServiceProtocol = StorageContainer.shared.fileService
    ) {
        self.realmService = realmService
        self.fileService = fileService
    }
    
    // MARK: - Private Methods
    private func saveProduct(with dto: MainDTO.Product) {
        let productObject = ProductObject(productID: dto.productID, name: dto.name, price: dto.price, imagePath: dto.image)
        realmService.create(productObject)
    }
    
    private func saveProducts(with productDTOs: [MainDTO.Product]) {
        let productObjects: [ProductObject] = productDTOs.map { dto in
            ProductObject(
                productID: dto.productID,
                name: dto.name,
                price: dto.price,
                imagePath: dto.image
            )
        }
        realmService.create(productObjects)
    }
    
    private func convertProductObjectsToDTOs(with productResults: Results<ProductObject>) -> [MainDTO.Product] {
        productResults.map { productObject in
            MainDTO.Product(
                productID: productObject.productID,
                name: productObject.name,
                price: productObject.price,
                image: productObject.imagePath
            )
        }
    }
    
    private func convertDTOToRealmObject(with dto: MainDTO.Product) -> ProductObject {
        ProductObject(productID: dto.productID, name: dto.name, price: dto.price, imagePath: dto.image)
    }
}

// MARK: - MainStorageWorkerLogic
extension MainStorageWorker: MainStorageWorkerLogic {
    func getProducts() -> [MainDTO.Product] {
        let products: Results<ProductObject> = realmService.read()
        let productDTOs: [MainDTO.Product] = products.map { productObject in
            MainDTO.Product(
                productID: productObject.productID,
                name: productObject.name,
                price: productObject.price,
                image: productObject.imagePath
            )
        }
        return productDTOs
    }
    
    // Completion is used to save images for new elements
    func proccessProducts(with productDTOs: [MainDTO.Product], completion: @escaping (([MainDTO.Product]) -> Void)) {
        let productObjects: Results<ProductObject> = realmService.read()
        var nonStoredProductDTOs: [MainDTO.Product] = []
        
        if productObjects.isEmpty {
            saveProducts(with: productDTOs)
            completion(productDTOs)
        } else {
            // Check stored items for non-matches
            let storedProductDTOs = convertProductObjectsToDTOs(with: productObjects)
            productDTOs.forEach { productDTO in
                if !storedProductDTOs.contains(productDTO) {
                    saveProduct(with: productDTO)
                    nonStoredProductDTOs.append(productDTO)
                }
            }
            completion(nonStoredProductDTOs)
        }
    }
    
    func saveImages(with imageFiles: [MainDTO.ImageFile]) {
        imageFiles.forEach { imageFile in
            fileService.saveImage(path: imageFile.path, image: imageFile.image)
        }
    }
    
    func getImage(by path: String) -> UIImage {
        fileService.getImage(path: path) ?? UIImage()
    }
}
