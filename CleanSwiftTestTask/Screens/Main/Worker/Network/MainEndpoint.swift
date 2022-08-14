//
//  MainEndpoint.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 12.08.22.
//

enum MainEndpoint: Endpoint {
    case list

    var compositePath: String {
        return basePath + rawValue
    }

    var rawValue: String {
        switch self {
        case .list:
            return "/cart/list"
        }
    }

    private var basePath: String {
        switch self {
        default:
            return "/developer-application-test"
        }
    }
}
