//
//  UIView+Mask.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 13.08.22.
//

import UIKit

extension UIView {
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
