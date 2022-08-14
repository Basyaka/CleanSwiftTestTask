//
//  DetailAssembly.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

enum DetailAssembly {
    static func assemble(data: Main.DetatilDataTransmissionModel) -> UIViewController {
        let presenter = DetailPresenter()
        let networkWorker = DetailNetworkWorker()
        let storageWorker = DetailStorageWorker()
        
        let interactor = DetailInteractor(
            presenter: presenter,
            networkWorker: networkWorker,
            storageWorker: storageWorker,
            data: data
        )
        
        let router = DetailRouter()
        let viewController = DetailViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
