//
//  DetailRouter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

final class DetailRouter: DetailRoutingLogic {
    // MARK: - Properties
    weak var viewController: UIViewController?

    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
