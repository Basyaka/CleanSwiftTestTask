//
//  MainDTO.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation
import UIKit

enum MainDTO {
    struct Response: Decodable {
        let products: [Product]
    }
    
    struct Product: Decodable, Equatable {
        let productID: String
        let name: String
        let price: Int
        let image: String

        enum CodingKeys: String, CodingKey {
            case productID = "product_id"
            case name, price, image
        }
    }
    
    struct ImageFile {
        let image: UIImage
        let path: String
    }
}
