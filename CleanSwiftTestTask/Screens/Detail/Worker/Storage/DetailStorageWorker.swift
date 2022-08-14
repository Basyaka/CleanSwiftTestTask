//
//  DetailStorageWorker.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 14.08.22.
//

import UIKit
import RealmSwift

final class DetailStorageWorker: DetailStorageWorkerLogic {
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
    
    // MARK: - Methods
    func getProduct(by primaryKey: String) -> DetailDTO.Product? {
        guard
            let productObject = realmService.realm.object(ofType: ProductObject.self, forPrimaryKey: primaryKey)
        else { return nil }

        return DetailDTO.Product(
            productID: productObject.productID,
            name: productObject.name,
            price: productObject.price,
            image: productObject.imagePath,
            description: productObject.productDescription ?? String.empty
        )
    }
    
    func getProductObject(by primaryKey: String) -> ProductObject? {
        realmService.realm.object(ofType: ProductObject.self, forPrimaryKey: primaryKey)
    }
    
    func updateProduct(_ productObject: ProductObject, description: String) {
        let dict: [String: Any?] = ["productDescription": description]
        realmService.update(productObject, with: dict)
    }
    
    func getImage(by path: String) -> UIImage {
        fileService.getImage(path: path) ?? UIImage()
    }
}
