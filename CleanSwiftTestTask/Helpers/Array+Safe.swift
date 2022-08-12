//
//  Array+Safe.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            if indices.contains(index),
               let newValue = newValue {
                self[index] = newValue
            }
        }
    }
}

