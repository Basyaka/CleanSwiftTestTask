//
//  CollectionViewCellModelProtocol.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

protocol CollectionViewCellModelProtocol {
    associatedtype DataType
    var callbackAction: ((DataType) -> Void)? { get set }
}
