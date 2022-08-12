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
        let worker = MainWorker()
        let interactor = MainInteractor(presenter: presenter, worker: worker)
        let router = MainRouter()
        let viewController = MainViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
