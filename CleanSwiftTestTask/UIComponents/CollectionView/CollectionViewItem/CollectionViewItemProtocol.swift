//
//  CollectionViewItemProtocol.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import UIKit

protocol CollectionViewItemProtocol {
    static var cellReuseIdentifier: String { get }
    var viewType: UIView.Type { get }
    func configure(view: UIView)
}
