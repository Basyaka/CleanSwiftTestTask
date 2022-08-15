//
//  DetailEndpoint.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

enum DetailEndpoint: Endpoint {
    case product(stringId: String)

    var compositePath: String {
        return basePath + rawValue
    }

    var rawValue: String {
        switch self {
        case .product(let stringId):
            return "/cart/\(stringId)/detail"
        }
    }

    private var basePath: String {
        switch self {
        default:
            return "/developer-application-test"
        }
    }
}
