//
//  ProductObject.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import Foundation
import RealmSwift

@objcMembers
class ProductObject: Object {
    dynamic var productID: String = String.empty
    dynamic var name: String = String.empty
    dynamic var price: Int = 0
    dynamic var imagePath: String = String.empty
    dynamic var productDescription: String? = nil
    
    convenience init(
        productID: String,
        name: String,
        price: Int,
        imagePath: String,
        productDescription: String? = nil
    ) {
        self.init()
        self.productID = productID
        self.name = name
        self.price = price
        self.imagePath = imagePath
        self.productDescription = productDescription
    }
    
    override class func primaryKey() -> String? {
        return "productID"
    }
}

