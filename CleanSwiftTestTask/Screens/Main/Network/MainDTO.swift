//
//  MainDTO.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

enum MainDTO {
    struct Response: Decodable {
        let products: [Product]
    }
    
    struct Product: Decodable {
        let productID: String
        let name: String
        let price: Int
        let image: String

        enum CodingKeys: String, CodingKey {
            case productID = "product_id"
            case name, price, image
        }
    }
}
