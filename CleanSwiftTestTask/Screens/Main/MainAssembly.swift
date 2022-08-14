//
//  MainAssembly.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

enum MainAssembly {
    static func assemble() -> UIViewController {
        let presenter = MainPresenter()
        let networkWorker = MainNetworkWorker()
        let storageWorker = MainStorageWorker()
        
        let interactor = MainInteractor(
            presenter: presenter,
            networkWorker: networkWorker,
            storageWorker: storageWorker
        )
        
        let router = MainRouter(dataStore: interactor)
        let viewController = MainViewController(interactor: interactor, router: router)
       
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
