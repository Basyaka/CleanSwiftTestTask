//
//  MainPresenter.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

final class MainPresenter {
    // MARK: - Nested Types
    private enum Constants {
        static let usaCurrencySymbol: String = "$"
    }
    
    // MARK: - Properties
    weak var viewController: MainDisplayLogic?
}

// MARK: - MainPresentationLogic
extension MainPresenter: MainPresentationLogic {
    func presentInitialData(_ response: Main.Initial.Response) {
        let products: [Main.Initial.ViewModel.Product] = response.products.map { product in
            Main.Initial.ViewModel.Product(
                productID: product.productID,
                title: product.title,
                price: "\(product.price) \(Constants.usaCurrencySymbol)",
                image: product.image
            )
        }
        let viewModel = Main.Initial.ViewModel(products: products)
        viewController?.displayInitialData(viewModel)
    }
}
