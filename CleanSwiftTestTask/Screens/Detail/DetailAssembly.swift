//
//  DetailAssembly.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

enum DetailAssembly {
    static func assemble() -> UIViewController {
        let presenter = DetailPresenter()
        let worker = DetailWorker()
        let interactor = DetailInteractor(presenter: presenter, worker: worker)
        let router = DetailRouter()
        let viewController = DetailViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
