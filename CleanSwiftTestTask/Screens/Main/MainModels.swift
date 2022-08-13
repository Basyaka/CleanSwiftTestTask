//
//  MainModels.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import UIKit

enum Main {
    enum Initial {
        struct Request {}
        
        struct Response {
            let products: [Product]
            
            struct Product {
                let productID: String
                let title: String
                let price: Int
                let image: UIImage
            }
        }
        
        struct ViewModel {
            let products: [Product]
            
            struct Product {
                let productID: String
                let title: String
                let price: String
                let image: UIImage
            }
        }
    }
    
    enum CollectionView {
        struct Section {
            let title: String
            let items: [Item]
        }
        
        struct Item {
            let productID: String
            let title: String
            let subtitle: String
            let image: UIImage
        }
    }
}
