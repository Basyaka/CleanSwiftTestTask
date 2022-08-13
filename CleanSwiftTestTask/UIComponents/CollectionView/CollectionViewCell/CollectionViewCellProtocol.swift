//
//  CollectionViewCellProtocol.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

protocol CollectionViewCellProtocol {
    associatedtype DataType
    var model: DataType! { get set }
}
