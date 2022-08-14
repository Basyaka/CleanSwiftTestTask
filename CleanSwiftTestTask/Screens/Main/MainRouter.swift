//
//  MainRouter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class MainRouter: MainRoutingLogic {
    // MARK: - Properties
    weak var viewController: UIViewController?
    private let dataStore: MainDataStore?
    
    // MARK: - Initialization
    init(dataStore: MainDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - MainRoutingLogic
    func routeToDetail() {
        guard
            let dataStore = dataStore,
            let data = dataStore.data
        else { return }
        
        let view = DetailAssembly.assemble(data: data)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
