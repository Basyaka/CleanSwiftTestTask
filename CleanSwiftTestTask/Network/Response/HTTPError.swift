//
//  HTTPError.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

import Foundation

enum HTTPError: Error {
    case networkError(Error)
    case parsingError
    case timeout
    case unsuccessStatus(Int)
    case incorrectUrl
    case undefined
}
