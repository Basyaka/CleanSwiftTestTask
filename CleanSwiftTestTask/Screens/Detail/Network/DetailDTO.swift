//
//  DetailDTO.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

enum DetailDTO {
    struct Product: Codable {
        let productID: String
        let name: String
        let price: Int
        let image: String
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case productID = "product_id"
            case name, price, image, description
        }
    }
}
